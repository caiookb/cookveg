import 'package:cookveg/card/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cookveg/menus/app_bar.dart';
import 'package:cookveg/menus/bottom_menu.dart';
import 'package:cookveg/menus/side_bar.dart';
import 'package:cookveg/services/storage.dart';

import 'package:flutter/material.dart';

class Home extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => const Size.fromHeight(70);
  CollectionReference recipes =
      FirebaseFirestore.instance.collection('recipes');

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: TopMenu(),
          endDrawer: SideDrawer(),
          body: Container(
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: Center(
                child: StreamBuilder<QuerySnapshot>(
              stream: recipes.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
                return new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return new CustomCard(
                      document.data()['name'],
                      document.data()['description'],
                      document.data()['image'],
                      document.data()['duration'],
                      document.data()['rating'],
                      document.data()['ingredients'],
                      document.data()['howToCook'],
                    );
                  }).toList(),
                );
              },
            )),
          ),
          bottomNavigationBar: BottomMenu()),
    );
  }
}
