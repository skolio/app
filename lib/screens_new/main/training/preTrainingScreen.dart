import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skolio/model/trainingModel.dart';
import 'package:skolio/screens_new/main/training/finishedTrainingScreen.dart';
import 'package:skolio/screens_new/main/training/trainingScreen.dart';
import 'package:skolio/widgets_new/general/halfCircleWidget.dart';

class PreTrainingScreen extends StatefulWidget {
  @override
  _PreTrainingScreenState createState() => _PreTrainingScreenState();
}

class _PreTrainingScreenState extends State<PreTrainingScreen> {
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    _handler();
  }

  @override
  dispose() {
    super.dispose();
    _disposed = true;
  }

  _handler() async {
    await Future.delayed(Duration(seconds: 2));
    if (_disposed) return;
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrainingScreen(),
      ),
    );
  }

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
            height: 250,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                Text(
                  "Mach dich bereit!",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Deine Übungen werden vorbereitet.",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(166, 166, 166, 1),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 30, left: 30, right: 30),
              child: Image.asset(
                "assets/Logo.png",
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
