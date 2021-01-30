import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'MainScreen.dart';
import 'Recipe/RecipeCapture.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, goto Main Screen
    var currentUser =
        await FirebaseAuth.instance.signInWithCredential(credential);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('currentUser', currentUser.toString());

    FormData data = FormData.fromMap({
      "email": FirebaseAuth.instance.currentUser.email,
    });

    Dio dio = new Dio();
    var responseData = await dio.post(baseURL + "/api/sign-up/", data: data);
    print(responseData);

    if (currentUser != null) {
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            child: MainScreen(),
            type: PageTransitionType.rightToLeft,
          ),
          (route) => false);
    }
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
              Image.asset(
                'assets/images/logo.png',
                scale: 4,
              ),
              Center(
                child: Text(
                  appName,
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
              padding: const EdgeInsets.only(bottom: 50),
              child: RaisedButton(
                onPressed: () {
                  signInWithGoogle();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14.0,
                    horizontal: 16.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image(
                          image: AssetImage("assets/images/google_logo.png"),
                          height: 25.0),
                      SizedBox(width: 24.0),
                      Text(
                        'Sign in with Google',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                            fontFamily: 'Roboto'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
