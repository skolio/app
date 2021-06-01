import 'package:flutter/material.dart';

class TrainingLoadingScreen extends StatefulWidget {
  @override
  _TrainingLoadingScreenState createState() => _TrainingLoadingScreenState();
}

class _TrainingLoadingScreenState extends State<TrainingLoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Mach dich bereit!",
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
