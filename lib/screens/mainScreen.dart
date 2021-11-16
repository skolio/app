import 'package:flutter/material.dart';
import 'package:skolio/bloc/trainingBloc.dart';
import 'package:skolio/screens/main/dataPrivacyScreen.dart';
import 'package:skolio/screens/main/imprintScreen.dart';
import 'package:skolio/screens/main/reordableTrainingPlanScreen.dart';
import 'package:skolio/screens/main/settingScreen.dart';
import 'package:skolio/screens/main/startTrainingScreen.dart';
import 'package:skolio/screens/main/statsScreen.dart';
import 'package:skolio/screens/main/trainingsPlanScreen.dart';
import 'package:skolio/screens/main/dashboardScreen.dart';

import '../bloc/authenticationBloc.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> _screens;

  List<String> _appBarTitle = [
    "SKOLIO",
    "TRAININGSPLAN",
    "TRAINING STARTEN",
    "DEINE ERFOLGE",
    "EINSTELLUNGEN",
    "DATENSCHUTZ",
    "IMPRESSUM",
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _screens = [
      DashboardScreen(changeCurrentScreen),
      // TrainingsPlanScreen(),
      ReordableTrainingPlanScreen(),
      StartTrainingScreen(changeCurrentScreen),
      StatsScreen(),
      SettingScreen(),
      DataPrivacyScreen(),
      ImprintScreen(),
    ];
    trainingBloc.fetchTrainingList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle[_currentIndex]),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          shrinkWrap: true,
          children: [
            GestureDetector(
              onTap: () {
                _currentIndex = 0;
                Navigator.pop(context);
                setState(() {});
              },
              child: DrawerHeader(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: Image.asset("assets/Logo.png"),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {
                _currentIndex = 1;
                Navigator.pop(context);
                setState(() {});
              },
              title: Text(
                "Trainingsplan",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {
                _currentIndex = 2;
                Navigator.pop(context);
                setState(() {});
              },
              title: Text(
                "Training starten",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {
                _currentIndex = 3;
                Navigator.pop(context);
                setState(() {});
              },
              title: Text(
                "Deine Erfolge",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {
                _currentIndex = 4;
                Navigator.pop(context);
                setState(() {});
              },
              title: Text(
                "Einstellungen",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {
                _currentIndex = 5;
                Navigator.pop(context);
                setState(() {});
              },
              title: Text(
                "Datenschutz",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {
                _currentIndex = 6;
                Navigator.pop(context);
                setState(() {});
              },
              title: Text(
                "Impressum",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              onTap: () {
                authenticationBloc.signOutUser();
              },
              title: Text(
                "Logout",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
      ),
      body: _screens[_currentIndex],
    );
  }

  changeCurrentScreen(int index) {
    _currentIndex = index;
    setState(() {});
  }
}
