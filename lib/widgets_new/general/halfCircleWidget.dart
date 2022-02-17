import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';

class HalfCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
      size: Size(double.infinity, 100),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color.fromRGBO(235, 122, 0, 1);
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, 0),
        height: size.height * 1.5,
        width: size.width * 1.5,
      ),
      0,
      pi,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
