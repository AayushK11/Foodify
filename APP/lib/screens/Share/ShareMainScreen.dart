import 'package:click_to_cook/screens/Share/ShareCapture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../constants.dart';
import 'ShareDetailScreen.dart';
import 'ShareScreen.dart';

class ShareMainScreen extends StatefulWidget {
  @override
  _ShareMainScreenState createState() => _ShareMainScreenState();
}

class _ShareMainScreenState extends State<ShareMainScreen> {
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
                          child: ShareScreen(),
                        ));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: textColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'I want to Eat',
                      style: TextStyle(
                        fontSize: 40,
                        color: primaryAppColor,
                        fontFamily: primaryFont,
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
                    child: Text(
                      'I want to Share',
                      style: TextStyle(
                        fontSize: 40,
                        color: primaryAppColor,
                        fontFamily: primaryFont,
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
