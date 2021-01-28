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

import 'RecipeScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  CameraController cameraController;
  List cameras;
  int selectedCameraIndex;
  int numberOfImagesUploaded = 0;
  bool isRecipeLoading = false;

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
        maxImages: 20,
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    // TODO: send resultList to backend
  }

  Widget cameraControl(context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
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
      ),
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
            child: RecipeScreen(),
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
              child: cameraPreview(),
            ),
            numberOfImagesUploaded != 0
                ? !isRecipeLoading
                    ? Align(
                        alignment: Alignment.topRight,
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Stack(
                              children: [
                                Container(
                                  width: 75.0,
                                  height: 75.0,
                                  child: new RawMaterialButton(
                                    fillColor: secondaryAppColor,
                                    shape: new CircleBorder(),
                                    elevation: 10.0,
                                    child: Icon(
                                      CupertinoIcons.checkmark_alt,
                                      size: 40,
                                    ),
                                    onPressed: () {
                                      getRecipe();
                                    },
                                  ),
                                ),
                                Container(
                                  width: 25.0,
                                  height: 25.0,
                                  child: new RawMaterialButton(
                                    fillColor: accentColor,
                                    shape: new CircleBorder(),
                                    elevation: 10.0,
                                    child: Text(
                                      numberOfImagesUploaded.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container()
                : Container(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: !isRecipeLoading
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: Colors.white,
                        ),
                        height: 150,
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
                          height: 300,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    primaryAppColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: 50),
                              Text(
                                'Loading Recipes...',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: primaryAppColor,
                                  fontFamily: 'Balsamiq Sans',
                                ),
                              ),
                            ],
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
