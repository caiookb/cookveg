import 'package:flutter/material.dart';

class RecipesDetails extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => const Size.fromHeight(70);

  String name;
  String duration;
  String howToCook;
  String image;
  String ingredients;
  int rating;

  RecipesDetails(String name, String duration, String howToCook, String image,
      String ingredients, int rating) {
    this.name = name;
    this.duration = duration;
    this.howToCook = howToCook;
    this.image = image;
    this.ingredients = ingredients;
    this.rating = rating;
  }

  Widget build(BuildContext context) {
    List ingredientsList = this.ingredients.split(';');
    List howToCookList = this.howToCook.split(';');

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green[700],
            toolbarHeight: 80,
            title: new Text(
              this.name,
              style: new TextStyle(color: Colors.white),
            ),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            )),
        body: Container(
            color: Colors.white,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Center(
              child: ListView(
                children: [
                  Container(
                    height: 300,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(this.image),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.grey[100],
                        border: Border.all(
                          color: Colors.white10,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  Wrap(
                    children: [
                      Text('Ingredientes',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          for (var i = 0; i < howToCookList.length; i++)
                            Wrap(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Wrap(
                                    children: [
                                      Text(
                                        ' - ' + howToCookList[i],
                                        style: TextStyle(fontSize: 16),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                        ],
                      )),
                  Wrap(
                    children: [
                      Text('Como preparar',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          for (var i = 0; i < ingredientsList.length; i++)
                            Wrap(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Wrap(
                                    children: [
                                      Text(
                                        ' - ' + ingredientsList[i],
                                        style: TextStyle(fontSize: 16),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                        ],
                      )),
                ],
              ),
            )),
      ),
    );
  }
}
