import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  String title;

  Loading(String title) {
    this.title = title;
  }

  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            this.title,
            style: TextStyle(color: Colors.black, fontSize: 26),
          )
        ],
      ),
    );
  }
}
