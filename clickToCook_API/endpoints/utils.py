from apiclient.discovery import build
from recipe_scrapers import scrape_me
import time
import cvlib as cv


def get_client_ip(request):
    x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
    if x_forwarded_for:
        ip = x_forwarded_for.split(',')[0]
    else:
        ip = request.META.get('REMOTE_ADDR')
    return ip


def recog_img(img):
    pass


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

# DRIVER FUNCTION - Recipe GEN

# query = "apple banana"
# results = list(recipe_gen(query))
# pprint(results)
