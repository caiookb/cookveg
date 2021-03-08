import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String title;
  Function press;
  Color color;
  double size;

  CustomButton(
    String title,
    Function press,
    Color color,
    double size,
  ) {
    this.title = title;
    this.press = press;
    this.color = color;
    this.size = size;
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return FlatButton(
        onPressed: this.press,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            this.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        minWidth: width * this.size,
        color: this.color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)));
  }
}
