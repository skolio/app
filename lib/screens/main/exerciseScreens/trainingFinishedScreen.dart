import 'package:flutter/material.dart';

class TrainingFinishedScreen extends StatefulWidget {
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
          SizedBox(height: 50),
          Container(
            child: Text(
              "Übung abgeschlossen",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
