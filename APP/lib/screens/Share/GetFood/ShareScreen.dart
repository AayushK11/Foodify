import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../constants.dart';
import 'ShareDetailScreen.dart';

class ShareScreen extends StatefulWidget {
  final Map foodList;

  ShareScreen({@required this.foodList});

  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {

  Widget foodCard(String title, String address, String imgURL, String price,
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
                            baseURL + imgURL,
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
                                      fontWeight: FontWeight.bold),
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
                itemCount: widget.foodList["result"].length,
                itemBuilder: (BuildContext context, int index) {
                  return foodCard(
                    widget.foodList["result"][index]['name'].toString(),
                    widget.foodList["result"][index]['address'].toString(),
                    widget.foodList["result"][index]['picture'].toString(),
                    widget.foodList["result"][index]['price'].toString(),
                    widget.foodList["result"][index],
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
