import 'package:flutter/material.dart';

class _FormTextInputState extends State<FormTextInput> {
  bool passwordVisibility = false;

  String hintText;
  Function validator;
  Function onSaved;
  bool isPassword;
  bool isEmail;

  _FormTextInputState(String hintText, Function validator, Function onSaved,
      bool isPassword, bool isEmail) {
    this.hintText = hintText;
    this.validator = validator;
    this.onSaved = onSaved;
    this.isPassword = isPassword;
    this.isEmail = isEmail;
  }

  void togglePasswordVisibility() {
    setState(() {
      this.passwordVisibility = !this.passwordVisibility;
    });
  }

  // ···
  Widget build(BuildContext context) {
    print(hintText);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        decoration: InputDecoration(
            suffixIcon: isPassword
                ? IconButton(
                    icon: passwordVisibility
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                    onPressed: () {
                      togglePasswordVisibility();
                    },
                  )
                : null,
            labelText: hintText,
            labelStyle: TextStyle(fontSize: 18, color: Colors.green[700])),
        obscureText: passwordVisibility ? true : false,
        validator: validator,
        onSaved: onSaved,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}

class FormTextInput extends StatefulWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEmail;

  FormTextInput({
    this.hintText,
    this.validator,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
  });

  @override
  _FormTextInputState createState() => _FormTextInputState(this.hintText,
      this.validator, this.onSaved, this.isPassword, this.isEmail);
}
