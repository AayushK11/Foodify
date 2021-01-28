import 'package:click_to_cook/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'RecipeDetailScreen.dart';

class RecipeScreen extends StatefulWidget {
  //TODO: remove this comment
  // final String recipeList;
  //
  // RecipeScreen({@required this.recipeList});

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
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
      },
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
      },
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

  Widget recipeCard(
      String title, String cookTime, String imgURL, Map recipeDetails) {
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
                            imgURL,
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
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
                            'Ready in $cookTime mins',
                            style: TextStyle(
                              fontSize: 13.5,
                              fontFamily: secondaryFont,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            CupertinoIcons.heart_fill,
                            color: Colors.grey,
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.add,
                                size: 15,
                                color: primaryAppColor,
                              ),
                              SizedBox(width: 3),
                              Text(
                                'Add',
                                style: TextStyle(
                                  color: primaryAppColor,
                                  fontFamily: secondaryFont,
                                ),
                              ),
                            ],
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
                  child: RecipeDetailScreen(
                    recipeDetails: recipeDetails,
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
          decodedDummyRecipeList['Title'],
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
                itemCount: decodedDummyRecipeList["Recipes"].length,
                itemBuilder: (BuildContext context, int index) {
                  return recipeCard(
                    decodedDummyRecipeList["Recipes"][index]['title']
                        .toString(),
                    decodedDummyRecipeList["Recipes"][index]['cooking_time']
                        .toString(),
                    decodedDummyRecipeList["Recipes"][index]['image']
                        .toString(),
                    decodedDummyRecipeList["Recipes"][index],
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
