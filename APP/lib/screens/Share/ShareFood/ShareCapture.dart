import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:click_to_cook/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';
import 'package:vibration/vibration.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../GetFood/ShareScreen.dart';
import 'ShareProfileScreen.dart';

class ShareCapture extends StatefulWidget {
  @override
  _ShareCaptureState createState() => _ShareCaptureState();
}

class _ShareCaptureState extends State<ShareCapture> {
  CameraController cameraController;
  List cameras;
  int selectedCameraIndex;
  bool isRecipeLoading = false;
  bool isImageCaptured = false;
  String imagePath;
  String name, address, phone, price, description;
  var image, galleryImage;

  var dummyDecodedData = {
    "result": [
      {
        "pk": 1,
        "address": "202, NY, USA",
        "phone_no": "1010101010",
        "picture": "/media/foodposts/Screenshot_from_2021-01-22_13-55-21.png",
        "name": "apple",
        "coordinates": "SRID=4326;POINT (73.91947028216656 18.55971312983079)",
        "price": "200",
        "description": "yum yum"
      },
      {
        "pk": 2,
        "address": "202, NY, USA",
        "phone_no": "1010101010",
        "picture": "/media/foodposts/Screenshot_from_2021-01-22_13-55-21.png",
        "name": "apple",
        "coordinates": "SRID=4326;POINT (73.91947028216656 18.55971312983079)",
        "price": "200",
        "description": "yum yum"
      }
    ]
  };

  @override
  void initState() {
    super.initState();
    availableCameras().then((value) {
      cameras = value;
      if (cameras.length > 0) {
        setState(() {
          selectedCameraIndex = 0;
        });
        initCamera(cameras[selectedCameraIndex]).then((value) {});
      } else {
        print('No camera available');
      }
    }).catchError((e) {
      print('Error : ${e.code}');
    });
  }

  Future initCamera(CameraDescription cameraDescription) async {
    if (cameraController != null) {
      await cameraController.dispose();
    }

    cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);

    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    if (cameraController.value.hasError) {
      print('Camera Error ${cameraController.value.errorDescription}');
    }

    try {
      await cameraController.initialize();
    } catch (e) {}

    if (mounted) {
      setState(() {});
    }
  }

  Widget cameraPreview() {
    if (cameraController == null || !cameraController.value.isInitialized) {
      return Scaffold(backgroundColor: Colors.black);
    }

    return AspectRatio(
      aspectRatio: MediaQuery.of(context).size.width /
          MediaQuery.of(context).size.height,
      child: CameraPreview(cameraController),
    );
  }

  onCapture(context) async {
    try {
      await cameraController.takePicture().then((value) async {
        if (await Vibration.hasVibrator()) {
          Vibration.vibrate(duration: 50);
        }

        print(value.path);

        String fileName = value.path.split('/').last;
        image = await MultipartFile.fromFile(
          value.path,
          filename: fileName,
        );
        galleryImage = image;

        setState(() {
          imagePath = value.path;
        });

        Toast.show("Recognising Image", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);

        try {
          //   FormData data = FormData.fromMap({
          //     "image": image,
          //   });
          //
          //   Dio dio = new Dio();
          //   var responseData = await dio.post(
          //     baseURL + "/api/share-image/",
          //     data: data,
          //   );
          //
          //   if (responseData != null) {
          //     name = responseData.data['result'];
          //   } else {
          //     name = 'apple';
          //     print("Something went wrong");
          //   }
        } catch (e) {
          name = 'apple';
          print("Something went wrong");
          print(e);
        }

        setState(() {
          isImageCaptured = true;
        });
      });
    } catch (e) {
      name = 'apple';
      print("Something went wrong");
      print(e);
    }
  }

  Future<void> loadAssets() async {
    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
      );

      List<MultipartFile> multipart = List<MultipartFile>();

      for (int i = 0; i < resultList.length; i++) {
        ByteData byteData = await resultList[i].getByteData();
        List<int> imageData = byteData.buffer.asUint8List();
        String fileName = "${resultList[i].name}";
        multipart.add(MultipartFile.fromBytes(
          imageData,
          filename: fileName,
        ));
      }
      if (multipart.isNotEmpty) {
        image = multipart[0];
        galleryImage = multipart[0];

        // FormData data = FormData.fromMap({
        //   "image": image,
        // });

        // Dio dio = new Dio();
        // var responseData = await dio.post(
        //   baseURL + "/api/share-image/",
        //   data: data,
        // );

        // if (responseData != null) {
        //   name = responseData.data['result'];
        // } else {
        name = 'apple';
        //   print("Something went wrong");
        // }

        setState(() {
          isImageCaptured = true;
        });
      }
    } on Exception catch (e) {
      error = e.toString();
      print(error);
      Toast.show("Something went wrong", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    }
    if (!mounted) return;
  }

  shareFood() async {
    try {
      setState(() {
        isImageCaptured = true;
      });

      Toast.show("Uploading Post!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      FormData data = FormData.fromMap({
        "email": FirebaseAuth.instance.currentUser.email,
        "name": name,
        "image": galleryImage,
        "phone_no": phone,
        "address": address,
        "lat": position.latitude,
        "lng": position.longitude,
        "price": price,
        "description": description,
      });

      Dio dio = new Dio();
      var responseData = await dio.post(
        baseURL + "/api/post-food/",
        data: data,
      );

      if (responseData != null) {
        print(responseData.data);
        Navigator.pop(context);
        Toast.show("Post Successful!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        Toast.show("Something went wrong", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
        Navigator.pop(context);
      }

      setState(() {
        isImageCaptured = false;
        imagePath = null;
      });
    } catch (e) {
      print(e);
      Toast.show("Something went wrong", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      setState(() {
        isImageCaptured = false;
        imagePath = null;
      });
    }
  }

  loadProfile() async {
    try {
      Toast.show("Profile Loading...", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);


      FormData data = FormData.fromMap({
        "email": FirebaseAuth.instance.currentUser.email,
      });

      Dio dio = new Dio();
      var responseData = await dio.post(
        baseURL + "/api/all-user-post/",
        data: data,
      );

      if (responseData != null) {
        print(responseData.data);
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: ShareProfileScreen(foodList: responseData.data),
          ),
        );
      } else {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: ShareProfileScreen(foodList: dummyDecodedData),
          ),
        );
      }
    } catch (e) {
      print(e);
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: ShareProfileScreen(foodList: dummyDecodedData),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: imagePath == null
                  ? cameraPreview()
                  : Image.asset(
                      imagePath,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: !isImageCaptured
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: Colors.white,
                        ),
                        height: 125,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              width: 75.0,
                              height: 75.0,
                              child: new RawMaterialButton(
                                fillColor: Colors.grey[300],
                                shape: new CircleBorder(),
                                elevation: 10.0,
                                child: Icon(
                                  CupertinoIcons.camera_fill,
                                  color: Colors.grey[700],
                                  size: 35,
                                ),
                                onPressed: () {
                                  onCapture(context);
                                },
                              ),
                            ),
                            Container(
                              width: 75.0,
                              height: 75.0,
                              child: new RawMaterialButton(
                                fillColor: Colors.grey[300],
                                shape: new CircleBorder(),
                                elevation: 10.0,
                                child: Icon(
                                  CupertinoIcons.paperclip,
                                  color: Colors.grey[700],
                                  size: 35,
                                ),
                                onPressed: () {
                                  loadAssets();
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    : Hero(
                        tag: 'container2',
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            color: Colors.white,
                          ),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Share your food',
                                  style: TextStyle(
                                    color: primaryAppColor,
                                    fontSize: 30,
                                    fontFamily: primaryFont,
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  onChanged: (value) {
                                    name = value;
                                  },
                                  controller: TextEditingController(text: name),
                                  decoration: InputDecoration(
                                    labelText: 'Item name',
                                    labelStyle: TextStyle(
                                      color: primaryAppColor,
                                    ),
                                    border: new OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: primaryAppColor),
                                    ),
                                    focusedBorder: new OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: primaryAppColor),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: TextFormField(
                                        onChanged: (value) {
                                          phone = value;
                                        },
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                          prefix: Text('+91 '),
                                          labelText: 'Phone',
                                          labelStyle: TextStyle(
                                            color: primaryAppColor,
                                          ),
                                          border: new OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: primaryAppColor,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: primaryAppColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      flex: 1,
                                      child: TextFormField(
                                        onChanged: (value) {
                                          price = value;
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          prefix: Text('₹ '),
                                          labelText: 'Price',
                                          labelStyle: TextStyle(
                                            color: primaryAppColor,
                                          ),
                                          border: new OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: primaryAppColor,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: primaryAppColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  onChanged: (value) {
                                    address = value;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Home Address',
                                    labelStyle: TextStyle(
                                      color: primaryAppColor,
                                    ),
                                    border: new OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: primaryAppColor),
                                    ),
                                    focusedBorder: new OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: primaryAppColor),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  onChanged: (value) {
                                    description = value;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Description',
                                    labelStyle: TextStyle(
                                      color: primaryAppColor,
                                    ),
                                    border: new OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: primaryAppColor),
                                    ),
                                    focusedBorder: new OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: primaryAppColor),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    shareFood();
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      color: primaryAppColor,
                                      borderRadius: BorderRadius.circular(
                                        5,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Share',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: primaryFont,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: new RawMaterialButton(
                      fillColor: primaryAppColor,
                      elevation: 10.0,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.doc_append,
                              color: Colors.white,
                              size: 25,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'My Posts',
                              style: TextStyle(
                                color: textColor,
                                fontFamily: secondaryFont,
                                fontSize: 17.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        loadProfile();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
