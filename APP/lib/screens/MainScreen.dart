import 'package:click_to_cook/screens/Recipe/RecipeCapture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../constants.dart';
import 'Share/ShareMainScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryAppColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: double.infinity),
          Hero(
            tag: 'logo',
            child: Image.asset(
              'assets/images/logo.png',
              scale: 4,
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                          duration: Duration(seconds: 1),
                          type: PageTransitionType.fade,
                          child: RecipeCapture(),
                        ));
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
                        'click2cook',
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
                          type: PageTransitionType.fade,
                          child: ShareMainScreen(),
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
                        'click2share',
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
