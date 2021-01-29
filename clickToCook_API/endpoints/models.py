# Create your models here.
from django.contrib.gis.db import models
from django.db.models.signals import pre_delete
from django.dispatch.dispatcher import receiver

# Create your models here.


class IPADDR(models.Model):
    ip_addr = models.CharField(max_length=100, default="")


class Image(models.Model):
    ip_addr = models.ForeignKey(to=IPADDR, on_delete=models.CASCADE)
    image = models.ImageField(upload_to="images")
    result = models.TextField(default="")


@receiver(pre_delete, sender=Image)
def mymodel_delete(sender, instance, **kwargs):
    instance.image.delete(False)


class EmUser(models.Model):

    email = models.EmailField(unique=True)


class FoodPost(models.Model):

    email = models.ForeignKey(to=EmUser, on_delete=models.CASCADE)
    picture = models.ImageField(upload_to="foodposts")
    address = models.TextField()
    phone_no = models.CharField(max_length=15)
    name = models.CharField(max_length=55)
    coordinates = models.PointField()
    price = models.CharField(max_length=5)


class ShareImage(models.Model):

    image = models.ImageField(upload_to="share_images")
    result = models.TextField(default="")
