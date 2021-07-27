import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skolio/widgets/authentication/changeEmailDialog.dart';
import 'package:skolio/widgets/authentication/changePasswordDialog.dart';
import 'package:skolio/widgets/authentication/deleteDialog.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => ChangeEmailDialog(),
            );
          },
          child: Container(
            height: 60,
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "E-Mail Adresse ändern",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.grey,
                  size: 35,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => ChangePasswordDialog(),
            );
          },
          child: Container(
            height: 60,
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Passwort ändern",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.grey,
                  size: 35,
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => DeleteDialog(),
            );
          },
          child: Container(
            height: 60,
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Account löschen",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.grey,
                  size: 35,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
