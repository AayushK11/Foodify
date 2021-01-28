import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../constants.dart';

class ShareDetailScreen extends StatefulWidget {
  final Map foodDetails;

  ShareDetailScreen({@required this.foodDetails});

  @override
  _ShareDetailScreenState createState() => _ShareDetailScreenState();
}

class _ShareDetailScreenState extends State<ShareDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.network(
                widget.foodDetails["picture"],
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
                    colors: [Colors.black, Colors.transparent],
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
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: double.infinity),
                Text(
                  widget.foodDetails["name"].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: secondaryFont,
                      color: Colors.black54),
                ),
                SizedBox(height: 10),
                Text(
                  "Pickup: " + widget.foodDetails["address"].toString(),
                  style: TextStyle(
                      fontFamily: secondaryFont, color: Colors.black54),
                ),
                SizedBox(height: 10),
                Text(
                  "Phone: +91-" + widget.foodDetails["phone_no"].toString(),
                  style: TextStyle(
                      fontFamily: secondaryFont, color: Colors.black54),
                ),
                SizedBox(height: 10),
                Text(
                  "For ₹" + widget.foodDetails["price"].toString(),
                  style: TextStyle(
                      fontFamily: secondaryFont, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
