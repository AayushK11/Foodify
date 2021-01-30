from apiclient.discovery import build
from recipe_scrapers import scrape_me
import time
from endpoints.models import Image, IPADDR
from ML.click2cook.model_prediction import predict_img
from ML.click2share.model_prediction import predict_img as share_predict_img


def get_client_ip(request):
    x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
    if x_forwarded_for:
        ip = x_forwarded_for.split(',')[0]
    else:
        ip = request.META.get('REMOTE_ADDR')
    return ip


def recog_img(img):
    return predict_img(img)


def predict_share_img(img):
    return share_predict_img(img)


def recipe_gen(query):
    if query != "":
        search_api_key = "AIzaSyA4ok0hFsK8K_YmhcYjSW8GY56UyIICx04"
        resource = build("customsearch", "v1",
                         developerKey=search_api_key).cse()
        result = resource.list(q=query, cx="1f6b8aea586f3422e").execute()
        for item in result["items"][:5]:
            recipe = scrape_me(item["link"], wild_mode=True)
            recipe_dict = {
                "title": recipe.title(),
                "cooking_time": recipe.total_time(),
                "servings": recipe.yields(),
                "ingredients": recipe.ingredients(),
                "image": recipe.image(),
                "instructions": recipe.instructions()
            }
            yield recipe_dict
            time.sleep(1)


def create_ip(ip_addr):
    if IPADDR.objects.filter(ip_addr=ip_addr).exists():
        ip_addr = IPADDR.objects.get(ip_addr=ip_addr)
    else:
        ip_addr = IPADDR.objects.create(ip_addr=ip_addr)
    return ip_addr.ip_addr


def idnetify_image(image, ip_addr_param):
    ip_addr = IPADDR.objects.get(ip_addr=ip_addr_param)
    image = Image.objects.create(image=image, ip_addr=ip_addr)
    objecte = recog_img(image.image.path)
    image.result = objecte
    context = {
        "id": image.pk,
        "label": objecte.title(),
        "img_url": image.image.url
    }
    image.save()
    return context


def u_recipe_gen(ip_address):
    ip_addr = IPADDR.objects.get(ip_addr=ip_address)
    img_objs = Image.objects.filter(ip_addr=ip_addr)
    query = ""
    for img in img_objs:
        query += f" {img.result}"
        img.delete()
    recipes = list(recipe_gen(query))
    context = {
        "Title": f"{query.title()} Recipes",
        "Recipes": recipes
    }
    return context


def req_post_getter(request, iterable):

    for item in iterable:
        yield request.POST.get(item, "")

# DRIVER FUNCTION - Recipe GEN

# query = "apple banana"
# results = list(recipe_gen(query))
# pprint(results)
