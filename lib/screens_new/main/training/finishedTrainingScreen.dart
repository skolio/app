import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skolio/bloc/navigatorBloc.dart';
import 'package:skolio/main.dart';
import 'package:skolio/screens_new/main/training/trainingScreen.dart';
import 'package:skolio/screens_new/mainScreen.dart';
import 'package:skolio/widgets_new/general/halfCircleWidget.dart';

class FinishedTrainingScreen extends StatefulWidget {
  final bool finishedTrainingPlan;

  FinishedTrainingScreen({@required this.finishedTrainingPlan});

  @override
  _FinishedTrainingScreenState createState() => _FinishedTrainingScreenState();
}

class _FinishedTrainingScreenState extends State<FinishedTrainingScreen> {
  final List<String> _title = [
    "Übung abgeschlossen",
    "Alle Übungen abgeschlossen",
  ];

  final List<String> _body = [
    "Du hast die Übung abgeschlossen und kannst jetzt weiter zur nächsten Übung gehen.",
    "Du hast für heute alle Übungen erfolgreich abgeschlossen.",
  ];

  final List<String> _secondButtonText = [
    "Zu deinen Ergebnissen",
    "Zum Dashboard",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.25 - 30,
            ),
            child: HalfCircle(),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.25,
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(bottom: 5, left: 30),
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 50,
                        spreadRadius: 0,
                        offset: Offset(0, 4),
                        color: Color.fromRGBO(0, 0, 0, 0.03),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: MediaQuery.of(context).size.height * 0.25 - 100,
                  ),
                  height: 240,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20),
                      SvgPicture.asset("assets/icons/orangeCheck.svg"),
                      SizedBox(height: 20),
                      Text(
                        _title[widget.finishedTrainingPlan ? 1 : 0],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        _body[widget.finishedTrainingPlan ? 1 : 0],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(166, 166, 166, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                if (!widget.finishedTrainingPlan)
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 66,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text("Weiter"),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrainingScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 66,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    child: Text(
                      _secondButtonText[widget.finishedTrainingPlan ? 1 : 0],
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () async {
                      Navigator.popUntil(context, (route) => route.isFirst);
                      navigatorBloc.changeIndex(1);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 30,
                      left: 50,
                      right: 50,
                      top: 20,
                    ),
                    child: Image.asset(
                      "assets/Logo.png",
                      width: MediaQuery.of(context).size.width * 0.6,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
