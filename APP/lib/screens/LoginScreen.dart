import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MainScreen.dart';

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
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text('google'),
            onPressed: signInWithGoogle,
          ),
        ),
      ),
    );
  }
}
