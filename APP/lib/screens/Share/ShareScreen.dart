import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../constants.dart';
import 'ShareDetailScreen.dart';

class ShareScreen extends StatefulWidget {
  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
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

  Widget recipeCard(String title, String address, String imgURL, String price,
      Map foodDetails) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        elevation: 3.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: InkWell(
            child: Container(
              height: 134,
              color: Colors.grey[100],
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        elevation: 2.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            imgURL,
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: secondaryFont),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            address,
                            style: TextStyle(
                              fontSize: 13.5,
                              fontFamily: secondaryFont,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '₹ ' + price,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: primaryAppColor,
                                    fontFamily: secondaryFont,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: ShareDetailScreen(
                    foodDetails: foodDetails,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryAppColor,
        leading: InkWell(
          child: Icon(Icons.arrow_back_rounded),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Foods Near You',
          style: TextStyle(
            fontFamily: primaryFont,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Hero(
          tag: 'container',
          child: Column(
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: decodedDummyRecipeList["result"].length,
                itemBuilder: (BuildContext context, int index) {
                  return recipeCard(
                    decodedDummyRecipeList["result"][index]['name'].toString(),
                    decodedDummyRecipeList["result"][index]['address']
                        .toString(),
                    decodedDummyRecipeList["result"][index]['picture']
                        .toString(),
                    decodedDummyRecipeList["result"][index]['price'].toString(),
                    decodedDummyRecipeList["result"][index],
                  );
                },
              ),
              SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
