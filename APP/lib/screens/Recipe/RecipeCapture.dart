import 'dart:convert';
import 'dart:typed_data';

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

class RecipeCapture extends StatefulWidget {
  @override
  _RecipeCaptureState createState() => _RecipeCaptureState();
}

class _RecipeCaptureState extends State<RecipeCapture> {
  CameraController cameraController;
  List cameras;
  int selectedCameraIndex;
  int numberOfImagesUploaded = 0;
  bool isRecipeLoading = false;

  Map decodedDummyRecipeList = {
    "Title": " Apples Recipes",
    "Recipes": [
      {
        "title": "Apple Smoothie Recipe",
        "cooking_time": 10,
        "servings": "2 servings",
        "ingredients": [
          "1 large Apple, peeled, cored and chopped",
          "1/2 cup Milk",
          "1/3 cup Vanilla Yogurt or Plain Yogurt",
          "5 Almonds (or 1 tablespoon almond powder), optional",
          "1 teaspoon Honey or Sugar",
          "A dash of ground Cinnamon, optional"
        ],
        "image":
            "https://cdn1.foodviva.com/static-content/food-images/smoothie-recipes/apple-smoothie-recipe/apple-smoothie-recipe.jpg",
        "instructions":
            "Peel and cut apple into halves. Remove the core and cut apple into large pieces.\nAdd apple and almonds in a blender jar.\nAdd milk, yogurt and honey.\nBlend until smooth and there are no chunks of fruit. Pour prepared smoothie into a chilled serving glass and sprinkle cinnamon over it. Drink it immediately for better taste because it will turn brown within half an hour."
      },
      {
        "title": "Apple Banana Smoothie Recipe",
        "cooking_time": 10,
        "servings": "1 serving",
        "ingredients": [
          "1 medium Gala Apple, peeled and chopped",
          "1/2 large Banana (fresh or frozen), peeled and chopped",
          "1/2 cup Orange Juice or Milk",
          "2 Ice Cubes, optional"
        ],
        "image":
            "https://cdn2.foodviva.com/static-content/food-images/smoothie-recipes/apple-banana-smoothie-recipe/apple-banana-smoothie-recipe.jpg",
        "instructions":
            "Cut apple into large pieces. If you like, peel the apple before using. Peel banana and cut into large pieces.\nPour orange juice into a blender jar.\nAdd apple, banana and ice cubes.\nBlend until smooth puree. Pour prepared banana apple smoothie into a chilled serving glass and serve. It will turn brown after some period, so drink it immediately to get maximum nutrients."
      },
      {
        "title": "Apple Ginger Juice Recipe",
        "cooking_time": 10,
        "servings": "2 servings",
        "ingredients": [
          "3 Apples",
          "1/2 inch piece of Ginger, peeled",
          "1/2 Lime or Lemon",
          "1/2 cup Water"
        ],
        "image":
            "https://cdn3.foodviva.com/static-content/food-images/juice-recipes/apple-ginger-juice-recipe/apple-ginger-juice-recipe.jpg",
        "instructions":
            "In this recipe, we have used 3 different types of apples – Red Delicious Apple,Granny Smith Apple (green apple) and Honey Crisp Apple. You can use any type of apple according to the availability. For nice flavor, use at least two different types of apples.\nCut the apples into medium pieces and remove the core.\nAdd cut apple, ginger and 1/2 cup water in a blender jar.\nSqueeze lime (or lemon) over it.\nBlend it in a blender or in a mixer grinder until smooth puree.\nPlace a large metal strainer over a large bowl. Pour prepared puree over it. If you don’t have a strainer, you can also use a cheesecloth or a nut-milk bag to strain the juice.\nPress the mixture using a metal spatula or a rubber spatula to get the maximum juice out of it.\nDiscard the remaining pulp.\nServe apple lemon ginger juice immediately and consume it within 10 minutes of preparation."
      },
      {
        "title": "Green Apple Juice Recipe",
        "cooking_time": 5,
        "servings": "1 serving",
        "ingredients": [
          "1 Green Apple",
          "1 stalk of Celery or 1/3 Cucumber",
          "1/4 cup Water",
          "1 teaspoon Honey, optional"
        ],
        "image":
            "https://cdn2.foodviva.com/static-content/food-images/juice-recipes/green-apple-juice-recipe/green-apple-juice-recipe.jpg",
        "instructions":
            "Wash apple and celery in running water and pat dry them.\nCut apple into medium pieces and remove the core. Cut celery into medium pieces.\nAdd apple and celery in a blender jar. Pour 1/4 cup water. Water is required to move all ingredients freely. If required, you can add up to 1/2 cup water.\nBlend them until smooth puree.\nPlace a fine metal strainer over a large bowl to strain the juice. Pour the prepared juice over it. You can also use cheesecloth or nut milk bag to strain the juice.\nPress the pulp with a rubber spatula or a metal spoon to get as much juice as possible. Discard the remaining pulp.\nAdd honey and stir with a spoon. Tangy and healthy green apple juice is ready to serve."
      },
      {
        "title": "Apple Orange Juice Recipe",
        "cooking_time": 5,
        "servings": "2 servings",
        "ingredients": [
          "1 Gala Apple (or any sweet apple)",
          "2 Oranges",
          "2 teaspoons Honey, optional",
          "1/2 to 3/4 cup Water"
        ],
        "image":
            "https://cdn3.foodviva.com/static-content/food-images/juice-recipes/apple-orange-juice-recipe/apple-orange-juice-recipe.jpg",
        "instructions":
            "Cut apple into large pieces and remove the core. Cut oranges into halves and remove seeds. Remove the skin of oranges and cut into large pieces or squeeze out the juice of orange either by squeezing it of using electric citrus juicer.\nAdd 1/2 to 3/4 cup water, apple pieces and orange pieces (or squeezed juice from oranges) into a blender jar.\nBlend until smooth puree.\nPlace a fine mesh strainer over a large bowl. Pour the juice over strainer.\nUse the spatula and gently press the puree to squeeze all the juice out of the pulp. Discard the remaining fibrous pulp.\nAdd honey into prepared orange apple juice and mix well. Pour it into serving glasses drink immediately to get maximum nutrients."
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
        Toast.show("Uploading Image", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);

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
        await dio
            .post(baseURL + "/api/image/", data: data)
            .then((response) => print(response))
            .catchError((error) => print(error));

        Toast.show("Image Uploaded Successfully", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);

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
        Navigator.push(
          context,
          PageTransition(
            duration: Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: RecipeScreen(recipeList: jsonDecode(response.body)),
          ),
        );
        setState(() {
          isRecipeLoading = false;
          numberOfImagesUploaded = 0;
        });
      } else {
        Navigator.push(
          context,
          PageTransition(
            duration: Duration(milliseconds: 500),
            type: PageTransitionType.fade,
            child: RecipeScreen(recipeList: decodedDummyRecipeList),
          ),
        );
        setState(() {
          isRecipeLoading = false;
          numberOfImagesUploaded = 0;
        });
      }
    } catch (e) {
      print(e);
      Navigator.push(
        context,
        PageTransition(
          duration: Duration(milliseconds: 500),
          type: PageTransitionType.fade,
          child: RecipeScreen(recipeList: decodedDummyRecipeList),
        ),
      );
      setState(() {
        isRecipeLoading = false;
        numberOfImagesUploaded = 0;
      });
    }
  }

  Future<void> loadAssets() async {
    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 20,
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
        FormData data = FormData.fromMap({
          "images": multipart,
        });

        Dio dio = new Dio();
        var responseData =
            await dio.post(baseURL + "/api/bulk-results/", data: data);
        if (responseData != null) {
          Navigator.push(
            context,
            PageTransition(
              duration: Duration(milliseconds: 500),
              type: PageTransitionType.fade,
              child: RecipeScreen(recipeList: jsonDecode(responseData.data)),
            ),
          );
          setState(() {
            isRecipeLoading = false;
            numberOfImagesUploaded = 0;
          });
        } else {
          Toast.show("Something wrong happened", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
          setState(() {
            isRecipeLoading = false;
            numberOfImagesUploaded = 0;
          });
        }
      }
    } on Exception catch (e) {
      error = e.toString();
      print(error);
      Toast.show("Something wrong happened", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      setState(() {
        isRecipeLoading = false;
        numberOfImagesUploaded = 0;
      });
    }
    if (!mounted) return;
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
                                    fillColor: primaryAppColor,
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
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: !isRecipeLoading
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
                                  fontFamily: primaryFont,
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
