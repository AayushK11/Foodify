from django.contrib import admin
from endpoints.models import Image, FoodPost, EmUser
from django.contrib.gis.admin import OSMGeoAdmin

# Register your models here.


class FoodPostAdmin(OSMGeoAdmin):
    list_display = ("phone_no", "name")


admin.site.register([Image, EmUser])
admin.site.register(FoodPost, FoodPostAdmin)
