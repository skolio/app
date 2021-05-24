import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset("assets/Logo.png"),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset("assets/BottomCircle.png"),
          ),
        ],
      ),
    );
  }
}
