import 'package:flutter/material.dart';

class Model {
  String name;
  String duration;
  String howToCook;
  String image;
  String ingredients;
  int rating;

  Model(
      {this.name,
      this.duration,
      this.howToCook,
      this.image,
      this.ingredients,
      this.rating});
}
