import 'package:flutter/material.dart';

class TopMenu extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => const Size.fromHeight(70);

  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Cookveg",
        style: TextStyle(color: Colors.white),
      ),
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.green[700],
    );
  }
}
