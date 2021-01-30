import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../../../constants.dart';

class ShareProfileScreen extends StatefulWidget {
  final Map foodList;

  ShareProfileScreen({@required this.foodList});

  @override
  _ShareProfileScreenState createState() => _ShareProfileScreenState();
}

class _ShareProfileScreenState extends State<ShareProfileScreen> {
  deletePost(pk) async {
    FormData data = FormData.fromMap(
        {"email": FirebaseAuth.instance.currentUser.email, "pk": pk});

    try {
      Dio dio = new Dio();
      var responseData = await dio.post(
        baseURL + "/api/delete-post/",
        data: data,
      );
      print(responseData);
    } catch (e) {
      print(e);
    }

    Toast.show("Post is deleted.", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }

  Widget foodCard(String title, String imgURL, String pk) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        elevation: 3.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        title,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: secondaryFont),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      deletePost(pk);
                    },
                    child: Icon(
                      CupertinoIcons.delete,
                      size: 30,
                      color: primaryAppColor,
                    ),
                  ),
                ],
              ),
            ),
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
          'Foods Posted by You',
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
                    widget.foodList["result"][index]['picture'].toString(),
                    widget.foodList["result"][index]['pk'].toString(),
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
