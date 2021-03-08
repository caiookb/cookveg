import 'package:cookveg/home/home.dart';
import 'package:cookveg/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cookveg/button/button.dart';
import 'package:cookveg/models/login_model.dart';
import 'package:cookveg/textInput/text_input.dart';
import 'package:validators/validators.dart' as validator;
import 'package:cookveg/signup/signup.dart';

class CustomTitle extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Text(
                'Cookveg',
                style: TextStyle(color: Colors.green[700], fontSize: 40),
              )
            ],
          ),
          Wrap(
            children: [
              Text('Venha conferir dicas e receitas sobre culinária vegana :)',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20,
                  ))
            ],
          )
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  LoginModel model = LoginModel();
  String email;
  String password;
  String error = '';

  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          FormTextInput(
              hintText: 'Email',
              isEmail: true,
              validator: (String value) {
                if (!validator.isEmail(value)) {
                  return 'Por favor coloque um email válido';
                }
                return null;
              },
              onSaved: (String value) => model.email = value),
          FormTextInput(
              hintText: 'Senha',
              isPassword: true,
              validator: (String value) {
                if (value.length < 5) {
                  return 'Senha tem que ter no mínimo 5 caracteres';
                }
                _formKey.currentState.save();
                return null;
              },
              onSaved: (String value) => model.password = value),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: CustomButton('Login', () {
                  if (_formKey.currentState.validate()) {
                    authService
                        .signIn(this.model)
                        .then((value) => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home())))
                        .catchError((e) {
                      setState(() {
                        this.error = e;
                      });
                    });
                  }
                }, Colors.green[700], 0.90),
              ),
            ],
          )
          // FormTextInput('Password', (Icons.visibility), email, 'Email'),
        ]));
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: new LoginView());
  }
}

void loginUser() async {}

class LoginView extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => const Size.fromHeight(70);

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTitle(),
                  LoginForm(),
                  CustomButton(
                      'Primeira vez na plataforma?',
                      () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp())),
                      Colors.blue,
                      0.90)
                ]),
          ),
        ),
      ),
    );
  }
}
