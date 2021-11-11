import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skolio/widgets/authentication/loadingDialog.dart';
import 'package:skolio/widgets/main/infoDialog.dart';
import 'package:skolio/widgets/ownSnackBar.dart';

import '../../bloc/authenticationBloc.dart';
import '../../widgets/authentication/ownTextField.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _passwordObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ANMELDUNG"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Image.asset("assets/Logo.png"),
            ),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: OwnTextField(
                hintTitle: "E-Mail",
                obscureText: false,
                rightWidget: null,
                controller: _emailController,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
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
      ),
    );
  }

  onTapContinue() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        getSnackBar(context, "Es darf kein Feld leer sein"),
      );
      return;
    }

    showDialog(context: context, builder: (context) => LoadingDialog());

    final response = await authenticationBloc.loginUser(
      _emailController.text,
      _passwordController.text,
    );

    Navigator.pop(context);

    if (response.code == "200") {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => InfoDialog(),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        getSnackBar(
          context,
          response.arguments["message"],
        ),
      );
      return;
    }
  }
}
