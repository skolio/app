import 'package:flutter/material.dart';
import 'package:skolio/screens/main/exerciseScreens/trainingScreen.dart';
import 'package:skolio/screens/main/statsScreen.dart';

class TrainingFinishedScreen extends StatefulWidget {
  final bool lastTraining;
  final Function(int) changeCurrentScreen;

  TrainingFinishedScreen(this.lastTraining, this.changeCurrentScreen);

  @override
  _TrainingFinishedScreenState createState() => _TrainingFinishedScreenState();
}

class _TrainingFinishedScreenState extends State<TrainingFinishedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(height: 40),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Logo.png"),
              ),
            ),
          ),
          SizedBox(height: 35),
          Container(
            child: Text(
              "Übung abgeschlossen",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!widget.lastTraining)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      child: Text("Nächste Übung"),
                      onPressed: startNextSession,
                    ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    child: Text("Statistiken"),
                    onPressed: gotoStats,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  startNextSession() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrainingScreen(widget.changeCurrentScreen),
      ),
    );
  }

  gotoStats() {
    Navigator.pop(context);
    widget.changeCurrentScreen(3);
  }
}
