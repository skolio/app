import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skolio/bloc/authenticationBloc.dart';
import 'package:skolio/widgets/authentication/loadingDialog.dart';
import 'package:skolio/widgets/authentication/ownTextField.dart';
import 'package:skolio/widgets/ownSnackBar.dart';

class ChangePasswordDialog extends StatefulWidget {
  @override
  _ChangePasswordDialogState createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  bool _passwordObscure = true;
  bool _newPasswordObscure = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OwnTextField(
              controller: _emailController,
              hintTitle: "E-Mail",
              obscureText: false,
            ),
            SizedBox(height: 20),
            OwnTextField(
              controller: _passwordController,
              hintTitle: "Passwort",
              obscureText: _passwordObscure,
              rightWidget: CupertinoButton(
                child: Icon(
                  Icons.remove_red_eye_sharp,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _passwordObscure = !_passwordObscure;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            OwnTextField(
              controller: _newPasswordController,
              hintTitle: "Neues Passwort",
              obscureText: _newPasswordObscure,
              rightWidget: CupertinoButton(
                child: Icon(
                  Icons.remove_red_eye_sharp,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _newPasswordObscure = !_newPasswordObscure;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onTapContinue,
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              child: Text("SPEICHERN"),
            ),
          ],
        ),
      ),
    );
  }

  onTapContinue() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _newPasswordController.text.isEmpty) {
      return;
    }

    showDialog(context: context, builder: (context) => LoadingDialog());

    final response = await authenticationBloc.changePassword(
      _emailController.text,
      _passwordController.text,
      _newPasswordController.text,
    );

    Navigator.pop(context);
    Navigator.pop(context);

    if (response.code != "200") {
      ScaffoldMessenger.of(context).showSnackBar(
        getSnackBar(
          context,
          response.arguments["message"],
        ),
      );
    }
  }
}
