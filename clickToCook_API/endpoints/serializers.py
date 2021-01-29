from rest_framework.serializers import ModelSerializer
from endpoints.models import FoodPost


class FoodPostSerializer(ModelSerializer):

    class Meta:

        model = FoodPost
        fields = ("pk", "address", "phone_no", "picture",
                  "name", "coordinates", "price", "description")
