import 'package:cookveg/home/home.dart';
import 'package:cookveg/models/signup_model.dart';
import 'package:cookveg/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:cookveg/button/button.dart';
import 'package:cookveg/textInput/text_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validators/validators.dart' as validator;

import 'dart:io';

class CustomTitle extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Text(
                'Cadastre-se agora',
                style: TextStyle(color: Colors.green[700], fontSize: 30),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Campos com * são obrigatórios\n',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  AuthService authService = AuthService();
  Model model = Model();
  File _image;
  String error = '';

  bool formValid = false;

  final picker = ImagePicker();

  Future getImage(ImageSource option) async {
    final pickedFile = await picker.getImage(source: option);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        model.image = _image;
      }
    });
  }

  @override
  void didUpdateWidget(SignUpForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('adasds');
    // aqui, podemos executar alguma lógica os parâmetros que recebemos via construtor
    // por exemplo:
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        FormTextInput(
            hintText: 'Nome *',
            validator: (String value) {
              if (value.length < 3) {
                return 'Nome muito curto :(';
              }
            },
            onSaved: (String value) => model.name = value),
        FormTextInput(
            hintText: 'Email *',
            isEmail: true,
            validator: (String value) {
              if (!validator.isEmail(value)) {
                return 'Por favor coloque um email válido';
              }
              return null;
            },
            onSaved: (String value) => model.email = value),
        Row(children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Precisamos de uma selfie sua :) *',
              style: TextStyle(fontSize: 20, color: Colors.green[700]),
            ),
          )
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              Container(
                width: 200,
                height: 200,
                child: _image == null
                    ? Text('Nenhuma imagem selecionada')
                    : Image.file(_image),
              ),
            ]),
            Column(
              children: [
                Row(
                  children: [
                    CustomButton('Selfie', () => getImage(ImageSource.camera),
                        Colors.blueGrey, 0.30)
                  ],
                ),
                Row(
                  children: [
                    CustomButton('Galeria', () => getImage(ImageSource.gallery),
                        Colors.blueGrey, 0.30)
                  ],
                )
              ],
            ),
          ],
        ),
        FormTextInput(
            hintText: 'Senha *',
            isPassword: true,
            validator: (String value) {
              if (value.length < 5) {
                return 'Senha tem que ter no mínimo 5 caracteres';
              }
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value) => model.password = value),
        FormTextInput(
          hintText: 'Confirmar senha *',
          isPassword: true,
          validator: (String value) {
            if (value.length < 5) {
              return 'Senha tem que ter no mínimo 5 caracteres';
            } else if (model.password != null && value != model.password) {
              return 'Senhas não são iguais';
            }
            return null;
          },
        ),
        Column(
          children: [
            Text(
              '* Ao fim do cadastro, enviaremos um email de confirmação ao email cadastrado :)',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                  fontStyle: FontStyle.italic),
            ),
            Container(
                margin: EdgeInsets.only(top: 15),
                child: Text(
                  this.error,
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: CustomButton('Cadastrar', () {
                if (this.model.image == null) {
                  setState(() {
                    this.error = 'Precisamos de uma selfie sua :D';
                  });
                }
                if (_formKey.currentState.validate() &&
                    this.model.image != null) {
                  authService
                      .registerUser(this.model)
                      .then((value) => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home())))
                      .catchError((e) {
                    setState(() {
                      this.error = e;
                    });
                  });
                }
              }, this.formValid ? Colors.green[700] : Colors.green[300], 0.90),
            ),
          ],
        )
      ]),
    );
  }
}

class SignUp extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => const Size.fromHeight(70);
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              CustomTitle(),
              SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}
