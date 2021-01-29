import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';

class ShareDetailsScreen extends StatefulWidget {
  final Map foodList;

  ShareDetailsScreen({@required this.foodList});

  @override
  _ShareDetailsScreenState createState() => _ShareDetailsScreenState();
}

class _ShareDetailsScreenState extends State<ShareDetailsScreen> {
  PanelController pc = new PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SlidingUpPanel(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        maxHeight: 750,
        minHeight: 100,
        controller: pc,
        body: Stack(children: [
          Column(
            children: [
              Image.network(
                baseURL + widget.foodList["picture"].toString(),
                width: double.infinity,
                fit: BoxFit.cover,
                height: 400,
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  widget.foodList["name"].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.black45,
                    fontFamily: primaryFont,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(5.0),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      widget.foodList["description"].toString(),
                      style: TextStyle(
                        fontFamily: secondaryFont,
                        fontSize: 17.5,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 15.0),
                      child: Text(
                        "₹" + widget.foodList["price"].toString(),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 35,
                          fontFamily: primaryFont,
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 2,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          var uri = Uri.parse(
                              "google.navigation:q=${widget.foodList["lat"].toString()},${widget.foodList["lng"].toString()}&mode=d");
                          if (await canLaunch(uri.toString())) {
                            await launch(uri.toString());
                          } else {
                            throw 'Could not launch ${uri.toString()}';
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 30.0,
                                width: 30.0,
                                child: Image.asset('assets/images/maps.png'),
                              ),
                              SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  widget.foodList["address"].toString(),
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontFamily: secondaryFont,
                                    fontSize: 17.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
        ]),
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
            SizedBox(height: 10),
            Text(
              'Order Now',
              style: TextStyle(
                color: primaryAppColor,
                fontSize: 35,
                fontFamily: primaryFont,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Divider(thickness: 2),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
              child: Material(
                borderRadius: BorderRadius.circular(10.0),
                elevation: 3.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    height: 134,
                    color: Colors.white,
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
                                  baseURL + widget.foodList["picture"].toString(),
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
                                  "Apple Smoothie",
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: secondaryFont),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "₹" + widget.foodList["price"].toString(),
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontFamily: primaryFont,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Pay via:",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 25,
                          fontFamily: primaryFont,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            EasyLoading.show(status: 'loading...');
                            Timer(
                              Duration(seconds: 2),
                              () => EasyLoading.showSuccess(
                                  'Payment Successful!'),
                            );
                          },
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                height: 100,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Image.asset(
                                    'assets/images/google_pay.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            EasyLoading.show(status: 'loading...');
                            Timer(
                              Duration(seconds: 2),
                              () => EasyLoading.showSuccess(
                                  'Payment Successful!'),
                            );
                          },
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                height: 100,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Image.asset(
                                    'assets/images/paytm.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RaisedButton(
                onPressed: () async {

                  var url = "tel:${widget.foodList["phone_no"].toString()}";
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: primaryAppColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.phone_fill,
                        size: 40,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Place Order',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontFamily: primaryFont,
                        ),
                      ),
                    ],
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
