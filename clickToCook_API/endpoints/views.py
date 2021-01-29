from rest_framework.decorators import api_view
from rest_framework.response import Response
from endpoints.utils import create_ip, idnetify_image, get_client_ip, recipe_gen, predict_share_img, req_post_getter
from django.contrib.gis.geos import Point
from django.contrib.gis.db.models.functions import Distance
from endpoints.models import Image, IPADDR, EmUser, FoodPost, ShareImage
from endpoints.serializers import FoodPostSerializer


@api_view(["POST"])
def get_image(request):
    ip_addr = create_ip(get_client_ip(request))
    image = request.FILES.get("image", None)
    context = idnetify_image(image, ip_addr)
    return Response(context)


@api_view(["POST"])
def bulk_images(request):
    ip_addr = create_ip(get_client_ip(request))
    images = request.FILES.getlist("images[]", [])
    for image in images:
        idnetify_image(image, ip_addr)
    context = recipe_gen(ip_addr)
    return Response(context)


@api_view(["GET"])
def get_recipes(request):
    ip_addr = get_client_ip(request)
    context = recipe_gen(ip_addr)
    return Response(context)


@api_view(["POST"])
def signup(request):

    email = request.POST.get("email", "")
    if not EmUser.objects.filter(email=email).exists():
        EmUser.objects.create(email=email)
    return Response({"result": "Success"})


# recognize shared image

@api_view(["POST"])
def recog_share_image(request):
    image = request.FILES.get("image", None)
    image = ShareImage.objects.create(image=image)
    result = predict_share_img(image.image.path)
    image.result = result
    image.save()
    return Response({"result": result})


@api_view(["POST"])
def post_food(request):
    email, name, address, phone_no, lat, lng, price, description = list(req_post_getter(
        request, ["email", "name", "address", "phone_no", "lat", "lng", "price", "description"]))
    email_obj = EmUser.objects.get(email=email)
    image = request.FILES.get("image", None)
    lat = float(lat)
    lng = float(lng)
    location = Point(lng, lat, srid=4326)
    FoodPost.objects.create(
        email=email_obj, address=address, phone_no=phone_no, coordinates=location, price=price, name=name, picture=image, description=description)
    return Response({"result": "Success"})


@api_view(["POST"])
def get_food(request):
    lat = float(request.POST.get("lat", 0.0))
    lng = float(request.POST.get("lng", 0.0))
    location = Point(lng, lat, srid=4326)
    queryset = FoodPost.objects.annotate(
        distance=Distance('coordinates', location)).order_by('distance')[:10]
    serialized_qs = FoodPostSerializer(queryset, many=True)
    return Response({"result": serialized_qs.data})


@api_view(["POST"])
def particular_user_food(request):
    email = request.POST.get("email", "")
    email_obj = EmUser.objects.get(email=email)
    queryset = FoodPost.objects.filter(email=email_obj)
    serialized_qs = FoodPostSerializer(queryset, many=True)
    return Response({"result": serialized_qs.data})


@api_view(["POST"])
def delete_post(request):
    pk = int(request.POST.get("pk"))
    email = request.POST.get("email")
    em_id = EmUser.objects.get(email=email).pk
    FoodPost.objects.get(pk=pk, email=em_id).delete()
    return Response({"result": "Success"})
