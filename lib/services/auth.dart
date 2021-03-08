import 'dart:io';

import 'package:cookveg/models/login_model.dart';
import 'package:cookveg/models/signup_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User user = FirebaseAuth.instance.currentUser;

  Future<void> sendEmailVerification() async {
    if (!user.emailVerified) {
      await user.sendEmailVerification().catchError((e) => print('deu ruim'));
    }
  }

  Future<void> updateUserName(String name) async {
    await user.updateProfile(displayName: name);
  }

  Future<void> registerUser(Model model) async {
    print(model.email);
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: model.email, password: model.password);

      await updateUserName(model.name);
      await _auth.setPersistence(Persistence.LOCAL);
      await sendEmailVerification();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'weak-password') {
        throw 'Essa senha é muito fácil :o';
      } else if (e.code == 'email-already-in-use') {
        throw 'Esse email já existe';
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signIn(LoginModel model) async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
              email: model.email, password: model.password))
          .user;

      await _auth.setPersistence(Persistence.LOCAL);

      return user;
    } catch (e) {
      print(e.message);
    }
  }

  Future signOut() async {
    try {
      await _auth.setPersistence(Persistence.NONE);

      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
