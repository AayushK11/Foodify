from django.urls import path
from endpoints import views

urlpatterns = [
    path("image/", views.get_image),
    path("bulk-results/", views.bulk_images),
    path("scrape/", views.get_recipes),
    path("sign-up/", views.signup),
    path("share-image/", views.recog_share_image),
    path("post-food/", views.post_food),
    path("get-food/", views.get_food),
    path("all-user-post/", views.particular_user_food),
    path("delete-post/", views.delete_post),
]
