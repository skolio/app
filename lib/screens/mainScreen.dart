import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skolio/bloc/navigatorBloc.dart';
import 'package:skolio/bloc/trainingBloc.dart';
import 'package:skolio/screens/main/dashboardScreen.dart';
import 'package:skolio/screens/main/accountScreen.dart';
import 'package:skolio/screens/main/resultScreen.dart';
import 'package:intl/date_symbol_data_local.dart';

class MainScreen extends StatefulWidget {
  MainScreen();

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final _scaffoldContext = GlobalKey<ScaffoldState>();

  int _currentIndex = 0;
  int _bottomIndex = 0;

  final List<String> _appBarTitle = [
    "Skolio",
    "Deine Erfolge",
    "Account",
    "Training starten",
    "Trainingsplan",
  ];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    trainingBloc.fetchTrainingList();
    navigatorBloc.indexStream.listen((event) {
      if (event != null) _changeScreen(event);
      print("We changed something here");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldContext,
      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       ListTile(
      //         title: Text("Training"),
      //       ),
      //     ],
      //   ),
      // ),
      appBar: _currentIndex == 0
          ? AppBar(
              title: Text("Skolio"),
              // leading: IconButton(
              //   icon: SvgPicture.asset("assets/icons/drawer.svg"),
              //   onPressed: () => _scaffoldContext.currentState.openDrawer(),
              // ),
            )
          : AppBar(
              backgroundColor: _currentIndex == 3
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
              elevation: 0,
              title: Text(
                _appBarTitle[_currentIndex],
                style: TextStyle(
                  color: _currentIndex == 3
                      ? Colors.white
                      : Theme.of(context).textTheme.bodyText1.color,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                  color: _currentIndex == 3
                      ? Colors.white
                      : Theme.of(context).textTheme.bodyText1.color,
                ),
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                    _bottomIndex = 0;
                  });
                },
              ),
            ),
      bottomNavigationBar: DelayedDisplay(
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 48,
                spreadRadius: 0,
                color: Color.fromRGBO(0, 0, 0, 0.08),
              ),
            ],
          ),
          child: BottomNavigationBar(
            elevation: 0,
            currentIndex: _bottomIndex,
            onTap: (newIndex) {
              setState(() {
                _currentIndex = newIndex;
                _bottomIndex = newIndex;
              });
            },
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Color.fromRGBO(184, 187, 193, 1),
            selectedLabelStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 11,
              fontFamily: GoogleFonts.montserrat().fontFamily,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: TextStyle(
              color: Color.fromRGBO(184, 187, 193, 1),
              fontSize: 11,
              fontFamily: GoogleFonts.montserrat().fontFamily,
              fontWeight: FontWeight.w600,
            ),
            items: [
              BottomNavigationBarItem(
                icon: SizedBox(
                  height: 27,
                  width: 27,
                  child: SvgPicture.asset(
                    "assets/icons/list.svg",
                    color: _bottomIndex == 0
                        ? Theme.of(context).primaryColor
                        : Color.fromRGBO(184, 187, 193, 1),
                  ),
                ),
                label: "Training",
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  height: 27,
                  width: 27,
                  child: SvgPicture.asset(
                    "assets/icons/star.svg",
                    color: _bottomIndex == 1
                        ? Theme.of(context).primaryColor
                        : Color.fromRGBO(184, 187, 193, 1),
                  ),
                ),
                label: "Erfolge",
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  height: 27,
                  width: 27,
                  child: SvgPicture.asset(
                    "assets/icons/person.svg",
                    color: _bottomIndex == 2
                        ? Theme.of(context).primaryColor
                        : Color.fromRGBO(184, 187, 193, 1),
                  ),
                ),
                label: "Account",
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: _initBlocs(),
        builder: (context, snapshot) {
          if (snapshot.data == null)
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          return IndexedStack(
            children: [
              DashboardScreen(),
              ResultScreen(),
              AccountScreen(),
            ],
            index: _currentIndex,
          );
        },
      ),
    );
  }

  _initBlocs() async {
    await trainingBloc.fetchTrainingList();
    return "";
  }

  _changeScreen(int index) {
    print("We are chaning the screen");
    if (index > 2)
      _bottomIndex = 0;
    else
      _bottomIndex = index;

    _currentIndex = index;
    setState(() {});
  }
}

class Info extends InheritedWidget {
  const Info({
    Key key,
    @required this.changeScreen,
    @required Widget child,
  })  : assert(changeScreen != null),
        assert(child != null),
        super(key: key, child: child);

  final Function(int) changeScreen;

  static Info of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Info>();
  }

  @override
  bool updateShouldNotify(covariant Info oldWidget) {
    return oldWidget.changeScreen != changeScreen;
  }
}
