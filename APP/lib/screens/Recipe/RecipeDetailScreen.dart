import 'dart:convert';

import 'package:click_to_cook/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Map recipeDetails;

  RecipeDetailScreen({@required this.recipeDetails});

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  PanelController pc = new PanelController();
  var splitInstructions;

  @override
  void initState() {
    splitInstructions =
        LineSplitter().convert(widget.recipeDetails["instructions"]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        maxHeight: 700,
        minHeight: 400,
        controller: pc,
        body: Stack(
          children: [
            Image.network(
              widget.recipeDetails["image"],
              fit: BoxFit.cover,
              height: 500,
              width: double.infinity,
            ),
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.transparent
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SafeArea(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(
                      CupertinoIcons.chevron_back,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: SafeArea(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(
                      CupertinoIcons.heart,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
        panel: Column(
          children: [
            SizedBox(height: 20),
            Container(
              height: 10,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, left: 30.0, right: 30.0, bottom: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: double.infinity),
                  Text(
                    widget.recipeDetails["title"].toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: secondaryFont,
                        color: Colors.black54),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.heart,
                        size: 15,
                        color: Colors.black45,
                      ),
                      SizedBox(width: 7),
                      Text(
                        '269',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black45,
                        ),
                      ),
                      SizedBox(width: 20),
                      Icon(
                        CupertinoIcons.time,
                        size: 15,
                        color: Colors.black45,
                      ),
                      SizedBox(width: 7),
                      Text(
                        widget.recipeDetails["cooking_time"].toString() + '\'',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black45,
                        ),
                      ),
                      SizedBox(width: 20),
                      Icon(
                        Icons.local_restaurant_rounded,
                        size: 15,
                        color: Colors.black45,
                      ),
                      SizedBox(width: 7),
                      Text(
                        widget.recipeDetails["servings"].toString(),
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: TabBar(
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 2.0),
                        insets: EdgeInsets.symmetric(horizontal: 75.0)),
                    tabs: [
                      Tab(
                        child: Text(
                          'Ingredients',
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Preparations',
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                    ],
                  ),
                  body: Container(
                    color: Color(0xffFcFcFc),
                    child: TabBarView(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.recipeDetails["ingredients"].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: index == 0
                                  ? const EdgeInsets.only(
                                      bottom: 8.0, left: 30, top: 30, right: 30)
                                  : index ==
                                          widget.recipeDetails["ingredients"]
                                                  .length -
                                              1
                                      ? const EdgeInsets.only(
                                          bottom: 30.0,
                                          left: 30,
                                          top: 0,
                                          right: 30)
                                      : const EdgeInsets.only(
                                          bottom: 8.0,
                                          left: 30,
                                          top: 0,
                                          right: 30),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '•  ',
                                    style: TextStyle(
                                      fontSize: 17.5,
                                      color: Colors.black54,
                                      fontFamily: secondaryFont,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      widget.recipeDetails["ingredients"][index]
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 17.5,
                                        color: Colors.black54,
                                        fontFamily: secondaryFont,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: splitInstructions.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: index == 0
                                  ? const EdgeInsets.only(
                                      bottom: 15.0,
                                      left: 30,
                                      top: 30,
                                      right: 30)
                                  : index == splitInstructions.length - 1
                                      ? const EdgeInsets.only(
                                          bottom: 30.0,
                                          left: 30,
                                          top: 0,
                                          right: 30)
                                      : const EdgeInsets.only(
                                          bottom: 15.0,
                                          left: 30,
                                          top: 0,
                                          right: 30),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '•  ',
                                    style: TextStyle(
                                      fontSize: 17.5,
                                      color: Colors.black54,
                                      fontFamily: secondaryFont,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      splitInstructions[index].toString(),
                                      style: TextStyle(
                                        fontSize: 17.5,
                                        color: Colors.black54,
                                        fontFamily: secondaryFont,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
