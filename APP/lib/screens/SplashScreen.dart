import 'dart:async';
import 'package:click_to_cook/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginScreen.dart';
import 'MainScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentUserData();
  }

  getCurrentUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isUserSignedIn = prefs.getString('currentUser') != null;

    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
              duration: Duration(seconds: 1),
              type: PageTransitionType.fade,
              child: isUserSignedIn ? MainScreen() : LoginScreen(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryAppColor,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  'Foodify',
                  style: TextStyle(
                    fontSize: 40,
                    color: textColor,
                    fontFamily: primaryFont,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 200.0),
              child: Text(
                "Turn your leftovers into\ndelicious food or money.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: textColor,
                  fontFamily: secondaryFont,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
