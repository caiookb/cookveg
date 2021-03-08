import 'package:cookveg/home/home.dart';
import 'package:cookveg/services/auth.dart';
import 'package:cookveg/welcome/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    print(user);
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[500],
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(100)),
            width: 200,
            height: 200,
            child: Text('oi'),
          ),
          Text(
            'É bom te ver por aqui, ${user.displayName.split(' ')[0]} :)',
            style: TextStyle(fontSize: 18, color: Colors.grey[800]),
          ),
          FlatButton(
              onPressed: () => print('oi'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person),
                  Column(
                    children: [
                      Text(' Meu perfil',
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[800]))
                    ],
                  )
                ],
              )),
          !user.emailVerified
              ? FlatButton(
                  onPressed: () => print('oi'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email),
                      Column(
                        children: [
                          Text(' Validar Email',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[800]))
                        ],
                      )
                    ],
                  ))
              : Row(),
          FlatButton(
              onPressed: () {
                authService.signOut().then((value) => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login())));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  Column(
                    children: [
                      Text(' Logout',
                          style:
                              TextStyle(fontSize: 18, color: Colors.red[800]))
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}
