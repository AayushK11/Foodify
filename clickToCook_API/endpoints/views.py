from rest_framework.decorators import api_view
from rest_framework.response import Response
from endpoints.utils import create_ip, idnetify_image, get_client_ip, recipe_gen
from django.contrib.gis.geos import Point
from django.contrib.gis.db.models.functions import Distance
from endpoints.models import Image, IPADDR, EmUser, FoodPost
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
