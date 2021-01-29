import 'package:click_to_cook/screens/Share/ShareFood/ShareCapture.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';
import '../../constants.dart';
import 'GetFood/ShareScreen.dart';

class ShareMainScreen extends StatefulWidget {
  @override
  _ShareMainScreenState createState() => _ShareMainScreenState();
}

class _ShareMainScreenState extends State<ShareMainScreen> {
  Map decodedDummyRecipeList = {
    "result": [
      {
        "id": 1,
        "picture":
            "https://cdn1.foodviva.com/static-content/food-images/smoothie-recipes/apple-smoothie-recipe/apple-smoothie-recipe.jpg",
        "address": "Vadgaon Budruk, Pune",
        "phone_no": "9179279755",
        "name": "Apple Smoothie",
        "coordinates": "SRID=4326;POINT (73.8567 18.5204)",
        "price": "69",
        "email": "kanhapatildurg@gmail.com"
      },
      {
        "id": 1,
        "picture":
            "https://cdn1.foodviva.com/static-content/food-images/smoothie-recipes/apple-smoothie-recipe/apple-smoothie-recipe.jpg",
        "address": "Vadgaon Budruk, Pune",
        "phone_no": "9179279755",
        "name": "Apple Smoothie",
        "coordinates": "SRID=4326;POINT (73.8567 18.5204)",
        "price": "69",
        "email": "kanhapatildurg@gmail.com"
      },
      {
        "id": 1,
        "picture":
            "https://cdn1.foodviva.com/static-content/food-images/smoothie-recipes/apple-smoothie-recipe/apple-smoothie-recipe.jpg",
        "address": "Vadgaon Budruk, Pune",
        "phone_no": "9179279755",
        "name": "Apple Smoothie",
        "coordinates": "SRID=4326;POINT (73.8567 18.5204)",
        "price": "69",
        "email": "kanhapatildurg@gmail.com"
      }
    ]
  };

  gotoEatScreen() async {
    try {
      Toast.show("Loading Posts!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      FormData data = FormData.fromMap({
        "lat": position.latitude,
        "lng": position.longitude,
      });

      Dio dio = new Dio();
      var responseData = await dio.post(
        baseURL + "/api/get-food/",
        data: data,
      );

      if (responseData != null) {
        print(responseData.data);
        Navigator.push(
            context,
            PageTransition(
              duration: Duration(seconds: 1),
              type: PageTransitionType.fade,
              child: ShareScreen(foodList: responseData.data),
            ));
      } else {
        Navigator.push(
            context,
            PageTransition(
              duration: Duration(seconds: 1),
              type: PageTransitionType.fade,
              child: ShareScreen(foodList: decodedDummyRecipeList),
            ));
      }
    } catch (e) {
      print(e);
      Navigator.push(
          context,
          PageTransition(
            duration: Duration(seconds: 1),
            type: PageTransitionType.fade,
            child: ShareScreen(foodList: decodedDummyRecipeList),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryAppColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: double.infinity),
          Column(
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/images/logo.png',
                  scale: 4,
                ),
              ),
              Center(
                child: Text(
                  'click2share',
                  style: TextStyle(
                    fontSize: 40,
                    color: textColor,
                    fontFamily: primaryFont,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RaisedButton(
                  onPressed: () {
                    gotoEatScreen();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: textColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Hero(
                      tag: 'container1',
                      child: Text(
                        'I want to Eat',
                        style: TextStyle(
                          fontSize: 30,
                          color: primaryAppColor,
                          fontFamily: primaryFont,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                          duration: Duration(seconds: 1),
                          type: PageTransitionType.fade,
                          child: ShareCapture(),
                        ));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: textColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Hero(
                      tag: 'container2',
                      child: Text(
                        'I want to Share',
                        style: TextStyle(
                          fontSize: 30,
                          color: primaryAppColor,
                          fontFamily: primaryFont,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
