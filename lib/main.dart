import 'package:cookveg/home/home.dart';
import 'package:cookveg/signup/signup.dart';
import 'package:cookveg/welcome/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';
// Import the firebase_core plugin
// import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    print(user);

    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SignUp();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          if (user != null) return Home();
          return Login();
        }

        return SignUp();
      },
    );
  }
}
