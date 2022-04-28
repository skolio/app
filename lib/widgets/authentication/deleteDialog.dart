import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skolio/bloc/authenticationBloc.dart';
import 'package:skolio/widgets/ownSnackBar.dart';
import 'package:skolio/widgets/general/ownTextField.dart';

class DeleteDialog extends StatefulWidget {
  @override
  _DeleteDialogState createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
            Text(
              "Willst du wirklich deinen Account löschen?",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Column(
              children: [
                OwnTextField(
                  textEditingController: _emailController,
                  hintText: "E-Mail",
                  obscure: false,
                ),
                SizedBox(height: 20),
                OwnTextField(
                  textEditingController: _passwordController,
                  hintText: "Passwort",
                  obscure: true,
                ),
                SizedBox(height: 20),
              ],
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text("Ja"),
                    onPressed: () async {
                      final response = await authenticationBloc.deleteUser(
                        _emailController.text,
                        _passwordController.text,
                      );
                      Navigator.pop(context);
                      if (response.code != "200") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          getSnackBar(
                            context,
                            response.arguments["message"],
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text("Nein"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
