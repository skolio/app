import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skolio/screens/authentication/loginScreen.dart';
import 'package:skolio/widgets/authentication/loadingDialog.dart';
import 'package:skolio/widgets/ownSnackBar.dart';
import 'package:skolio/widgets/authentication/ownTextField.dart';

import '../../bloc/authenticationBloc.dart';
import '../../model/userModel.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _checkBoxValue = false;
  bool _passwordObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REGISTRIERUNG"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Image.asset("assets/Logo.png"),
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: OwnTextField(
                  hintTitle: "Name",
                  obscureText: false,
                  rightWidget: null,
                  controller: _nameController,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: OwnTextField(
                  hintTitle: "E-Mail",
                  obscureText: false,
                  rightWidget: null,
                  controller: _emailController,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: OwnTextField(
                  hintTitle: "Passwort",
                  obscureText: _passwordObscureText,
                  rightWidget: CupertinoButton(
                    child: Icon(
                      Icons.remove_red_eye_sharp,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordObscureText = !_passwordObscureText;
                      });
                    },
                  ),
                  controller: _passwordController,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      child: Checkbox(
                        activeColor: Theme.of(context).primaryColor,
                        value: _checkBoxValue,
                        onChanged: (newValue) {
                          setState(() {
                            _checkBoxValue = !_checkBoxValue;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: "Ich akzeptiere die "),
                            TextSpan(
                              text: "AGBs",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(text: " und die "),
                            TextSpan(
                              text: "Datenschutzbestimmungen",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                child: Text(
                  "WEITER",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: onTapContinue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  onTapContinue() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        getSnackBar(context, "Es darf kein Feld leer sein"),
      );
      return;
    }

    if (!_checkBoxValue) {
      ScaffoldMessenger.of(context).showSnackBar(
        getSnackBar(context,
            "Sie müssen den AGBs und Datenschutzbestimmungen akzeptieren um die Registrierung zu vervollständingen"),
      );
      return;
    }

    showDialog(context: context, builder: (context) => LoadingDialog());

    final response = await authenticationBloc.registerUser(
      UserModel.fromMap(
        {
          "email": _emailController.text,
          "username": _nameController.text,
          "uid": "",
          "trainingPlan": [],
        },
        {},
      ),
      _passwordController.text,
    );

    Navigator.pop(context);

    if (response.code == "200") {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );

      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Vielen Dank für deine Registrierung bei Skolio. Wir haben die eine E-Mail geschickt. Bitte verifiziere deine E-Mailadresse und logge dich danach bei Skolio ein",
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        getSnackBar(context, response.arguments["message"]),
      );
    }
  }
}
