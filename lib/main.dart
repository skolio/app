import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/subjects.dart';
import 'package:skolio/bloc/analyitcsBloc.dart';
import 'package:skolio/screens/loadingScreen.dart';
import 'package:skolio/screens/authentication/loginScreen.dart';
import 'package:skolio/screens/mainScreen.dart';

import 'bloc/authenticationBloc.dart';

// final FirebaseAnalytics _analytics = FirebaseAnalytics();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  analyticsBloc.logAppStart();
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

class _MainAppState extends State<MainApp> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      navigatorObservers: [
        // FirebaseAnalyticsObserver(analytics: _analytics),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Color.fromRGBO(235, 122, 0, 1),
          titleTextStyle: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w600,
          ),
        ),
        primaryColor: Color.fromRGBO(235, 122, 0, 1),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Color.fromRGBO(235, 122, 0, 1),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Color.fromRGBO(20, 52, 80, 1),
                displayColor: Color.fromRGBO(20, 52, 80, 1),
              ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            primary: Color.fromRGBO(235, 122, 0, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
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
                      snapshot.data == null ? LoginScreen() : MainScreen(),
                ),
        ),
      ),
    );
  }

  initAsync() async {
    await authenticationBloc.initUser();
    return "Done";
  }

  @override
  bool get wantKeepAlive => true;
}
