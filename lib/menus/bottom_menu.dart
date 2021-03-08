import 'package:flutter/material.dart';

class MenuOptions {
  const MenuOptions(this.title, this.icon, this.color);
  final String title;
  final IconData icon;
  final MaterialColor color;
}

class BottomMenu extends StatelessWidget {
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      backgroundColor: Colors.green[700],
      fixedColor: Colors.white,
      onTap: (value) {},
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Colors.white,
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.lock),
            backgroundColor: Colors.white,
            label: 'Restrito',
            activeIcon: Icon(Icons.lock_open))
      ],
    );
  }
}
