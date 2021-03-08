import 'package:cookveg/models/recipes_model.dart';
import 'package:cookveg/recipes_details/recipes_details.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  String title;
  String description;
  String duration;
  String image;
  String howToCook;
  String ingredients;
  int rating;

  CustomCard(String title, String description, String image, String duration,
      int rating, String howToCook, String ingredients) {
    this.title = title;
    this.description = description;
    this.image = image;
    this.duration = duration;
    this.rating = rating;
    this.howToCook = howToCook;
    this.ingredients = ingredients;
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Center(
      child: Card(
        borderOnForeground: true,
        child: InkWell(
          splashColor: Colors.black,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RecipesDetails(
                      title, duration, howToCook, image, ingredients, rating)),
            );
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(this.image),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.7), BlendMode.darken)),
                color: Colors.grey[100],
                border: Border.all(
                  color: Colors.white10,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(5)),
            width: width * 0.85,
            height: 165,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.article,
                      color: Colors.green[300],
                    ),
                    Text(
                      ' ' + this.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                Wrap(
                  children: [
                    Text(this.description,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.timer,
                              color: Colors.green[300],
                            ),
                            Text(' ' + this.duration,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ))
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        for (var i = 0; i < this.rating; i++)
                          Icon(
                            Icons.star_rate,
                            color: Colors.green[300],
                          )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
