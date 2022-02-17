import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skolio/bloc/authenticationBloc.dart';
import 'package:skolio/widgets/authentication/loadingDialog.dart';
import 'package:skolio/widgets_new/general/ownTextField.dart';
import 'package:skolio/widgets/ownSnackBar.dart';

class ChangeEmailDialog extends StatefulWidget {
  @override
  _ChangeEmailDialogState createState() => _ChangeEmailDialogState();
}

class _ChangeEmailDialogState extends State<ChangeEmailDialog> {
  final _emailController = TextEditingController();
  final _newEmailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _passwordObscure = true;

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
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OwnTextField(
              textEditingController: _emailController,
              hintText: "E-Mail",
              obscure: false,
            ),
            SizedBox(height: 20),
            OwnTextField(
              textEditingController: _newEmailController,
              hintText: "Neue E-Mail",
              obscure: false,
            ),
            SizedBox(height: 20),
            OwnTextField(
              textEditingController: _passwordController,
              hintText: "Passwort",
              obscure: _passwordObscure,
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text("Speichern"),
                onPressed: onTapContinue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  onTapContinue() async {
    if (_emailController.text.isEmpty ||
        _newEmailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      return;
    }

    showDialog(context: context, builder: (context) => LoadingDialog());

    final response = await authenticationBloc.changeEmail(
      _emailController.text,
      _newEmailController.text,
      _passwordController.text,
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
