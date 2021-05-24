import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skolio/widgets/ownTextField.dart';

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("REGISTRIERUNG"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).size.height * 0.1,
          top: MediaQuery.of(context).size.height * 0.1,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Image.asset("assets/Logo.png"),
            ),
            OwnTextField(
              hintTitle: "Name",
              obscureText: false,
              rightWidget: null,
              controller: _nameController,
            ),
            OwnTextField(
              hintTitle: "E-Mail",
              obscureText: false,
              rightWidget: null,
              controller: _emailController,
            ),
            OwnTextField(
              hintTitle: "Passwort",
              obscureText: _passwordObscureText,
              rightWidget: CupertinoButton(
                child: Icon(Icons.remove_red_eye_sharp),
                onPressed: () {
                  setState(() {
                    _passwordObscureText = !_passwordObscureText;
                  });
                },
              ),
              controller: _passwordController,
            ),
            Row(
              children: [
                Checkbox(
                  value: _checkBoxValue,
                  onChanged: (newValue) {
                    setState(() {
                      _checkBoxValue = !_checkBoxValue;
                    });
                  },
                ),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "Ich akzeptiere die "),
                        TextSpan(text: "AGBs "),
                        TextSpan(text: "und die "),
                        TextSpan(text: "Datenschutzbestimmungen"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              child: Text(
                "WEITER",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
