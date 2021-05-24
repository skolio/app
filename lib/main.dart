import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:skolio/screens/authentication/startScreen.dart';
import 'package:skolio/screens/loadingScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(235, 123, 0, 1),
      ),
      home: FutureBuilder(
        future: initAsync(),
        builder: (context, snapshot) =>
            snapshot.data == null ? LoadingScreen() : StartScreen(),
      ),
    );
  }

  initAsync() async {
    await Future.delayed(Duration(seconds: 2));
    return 0;
  }
}
