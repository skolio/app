import 'package:flutter/material.dart';
import 'package:skolio/bloc/authenticationBloc.dart';

class LogOutDialog extends StatefulWidget {
  @override
  _LogOutDialogState createState() => _LogOutDialogState();
}

class _LogOutDialogState extends State<LogOutDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      titleTextStyle: TextStyle(
        fontSize: 18,
        color: Theme.of(context).textTheme.bodyText1.color,
        fontWeight: FontWeight.w600,
      ),
      title: Text("Möchtest du dich bei Skolio abmelden?"),
      actions: [
        TextButton(
          child: Text(
            "Ja",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          onPressed: () {
            authenticationBloc.signOutUser();
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text(
            "Abbrechen",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
