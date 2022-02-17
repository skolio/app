import 'package:flutter/material.dart';
import 'package:skolio/bloc/authenticationBloc.dart';
import 'package:skolio/screens_new/main/settings/dataPrivacyScreen.dart';
import 'package:skolio/screens_new/main/settings/imprintScreen.dart';
import 'package:skolio/widgets_new/authentication/changeEmailDialog.dart';
import 'package:skolio/widgets_new/authentication/changePasswordDialog.dart';
import 'package:skolio/widgets_new/authentication/deleteDialog.dart';
import 'package:skolio/widgets_new/main/account/logOutDialog.dart';
import 'package:skolio/widgets_new/main/account/overviewItem.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          SizedBox(height: 20),
          OverviewItem(
            title: "E-Mail Adresse ändern",
            onTap: () => showDialog(
              context: context,
              builder: (context) => ChangeEmailDialog(),
            ),
          ),
          SizedBox(height: 10),
          OverviewItem(
            title: "Passwort ändern",
            onTap: () => showDialog(
              context: context,
              builder: (context) => ChangePasswordDialog(),
            ),
          ),
          SizedBox(height: 10),
          OverviewItem(
            title: "Logout",
            onTap: () => showDialog(
              context: context,
              builder: (context) => LogOutDialog(),
            ),
          ),
          SizedBox(height: 10),
          OverviewItem(
            title: "Account löschen",
            onTap: () => showDialog(
              context: context,
              builder: (context) => DeleteDialog(),
            ),
          ),
          SizedBox(height: 10),
          OverviewItem(
            title: "Datenschutz",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DataPrivacyScreen(),
              ),
            ),
          ),
          SizedBox(height: 10),
          OverviewItem(
            title: "Impressum",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImprintScreen(),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
