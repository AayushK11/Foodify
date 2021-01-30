import 'package:click_to_cook/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'RecipeDetailScreen.dart';

class RecipeScreen extends StatefulWidget {
  final Map recipeList;

  RecipeScreen({@required this.recipeList});

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {

  Widget recipeCard(
      String title, String cookTime, String imgURL, Map recipeDetails) {
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
                    SizedBox(width: 10),
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
                            'Ready in $cookTime mins',
                            style: TextStyle(
                              fontSize: 13.5,
                              fontFamily: secondaryFont,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            CupertinoIcons.heart_fill,
                            color: Colors.grey,
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.add,
                                size: 15,
                                color: primaryAppColor,
                              ),
                              SizedBox(width: 3),
                              Text(
                                'Add',
                                style: TextStyle(
                                  color: primaryAppColor,
                                  fontFamily: secondaryFont,
                                ),
                              ),
                            ],
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
                  child: RecipeDetailScreen(
                    recipeDetails: recipeDetails,
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
          widget.recipeList['Title'],
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
                itemCount: widget.recipeList["Recipes"].length,
                itemBuilder: (BuildContext context, int index) {
                  return recipeCard(
                    widget.recipeList["Recipes"][index]['title']
                        .toString(),
                    widget.recipeList["Recipes"][index]['cooking_time']
                        .toString(),
                    widget.recipeList["Recipes"][index]['image']
                        .toString(),
                    widget.recipeList["Recipes"][index],
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
