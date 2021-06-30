import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skolio/screens/authentication/startScreen.dart';
import 'package:skolio/screens/loadingScreen.dart';

import 'bloc/authenticationBloc.dart';
import 'screens/mainScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
        textTheme: TextTheme(
          headline6: TextStyle(fontSize: 18),
        ),
      ),
      home: WillPopScope(
        onWillPop: () async => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Willst du wirklich Skolio verlassen?'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                child: Text("Nein"),
                onPressed: () => Navigator.pop(context, false),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                child: Text("Ja"),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          ),
        ),
        child: FutureBuilder(
          future: initAsync(),
          builder: (context, snapshot) => snapshot.data == null
              ? LoadingScreen()
              : StreamBuilder(
                  initialData: authenticationBloc.currentUser.value,
                  stream: authenticationBloc.currentUser,
                  builder: (context, snapshot) =>
                      snapshot.data == null ? StartScreen() : MainScreen(),
                ),
        ),
      ),
    );
  }

  initAsync() async {
    await Firebase.initializeApp();
    await authenticationBloc.initUser();
    return "Done";
  }
}
