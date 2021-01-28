import 'package:camera/camera.dart';
import 'package:click_to_cook/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';
import 'package:vibration/vibration.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'ShareScreen.dart';

class ShareCapture extends StatefulWidget {
  @override
  _ShareCaptureState createState() => _ShareCaptureState();
}

class _ShareCaptureState extends State<ShareCapture> {
  CameraController cameraController;
  List cameras;
  int selectedCameraIndex;
  int numberOfImagesUploaded = 0;
  bool isRecipeLoading = false;
  bool isImageCaptured = false;
  String imagePath;

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
      return Text('Loading');
    }

    return AspectRatio(
      aspectRatio: MediaQuery.of(context).size.width /
          MediaQuery.of(context).size.height,
      child: CameraPreview(cameraController),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    // TODO: send resultList to backend
  }

  Widget cameraControl(context) {
    return Row(
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
    );
  }

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

  onCapture(context) async {
    try {
      await cameraController.takePicture().then((value) async {
        if (await Vibration.hasVibrator()) {
          Vibration.vibrate(duration: 50);
        }

        setState(() {
          isImageCaptured = true;
          imagePath = value.path;
        });

        String fileName = value.path.split('/').last;
        FormData data = FormData.fromMap({
          "image": await MultipartFile.fromFile(
            value.path,
            filename: fileName,
          ),
        });

        Dio dio = new Dio();
        dio
            .post(baseURL + "image/", data: data)
            .then((response) => print(response))
            .catchError((error) => print(error));

        setState(() {
          numberOfImagesUploaded++;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  void getRecipe() async {
    setState(() {
      isRecipeLoading = true;
    });

    String url = baseURL + 'scrape/';
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        //TODO: navigate to next screen
      } else {
        // Toast.show("Something wrong happened", context,
        //     duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
        // setState(() {
        //   isRecipeLoading = false;
        // });
        Navigator.push(
          context,
          PageTransition(
            duration: Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: ShareScreen(),
          ),
        );
        setState(() {
          isRecipeLoading = false;
          numberOfImagesUploaded = 0;
        });
      }
    } catch (e) {
      print(e);
      Toast.show("Something wrong happened", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      setState(() {
        isRecipeLoading = false;
      });
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
              child: !isImageCaptured
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
                        child: cameraControl(context),
                      )
                    : Hero(
                        tag: 'container',
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
                                    // TODO
                                  },
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
                                          // TODO
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
                                                color: primaryAppColor),
                                          ),
                                          focusedBorder: new OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: primaryAppColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      flex: 1,
                                      child: TextFormField(
                                        onChanged: (value) {
                                          // TODO
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
                                                color: primaryAppColor),
                                          ),
                                          focusedBorder: new OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: primaryAppColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  onChanged: (value) {
                                    // TODO
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
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: double.infinity,
                                    height: 55,
                                    decoration: BoxDecoration(
                                        color: primaryAppColor,
                                        borderRadius: BorderRadius.circular(5)),
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
          ],
        ),
      ),
    );
  }
}
