import 'package:flutter/material.dart';

class OwnProgressIndicator extends StatefulWidget {
  final int value;
  final int maxValue;

  OwnProgressIndicator(this.value, this.maxValue);

  @override
  _OwnProgressIndicatorState createState() => _OwnProgressIndicatorState();
}

class _OwnProgressIndicatorState extends State<OwnProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    final barWidth = MediaQuery.of(context).size.width - 30;

    final progressWidth =
        barWidth * (widget.value.toDouble() / widget.maxValue.toDouble());
    return Container(
      height: 12,
      width: barWidth,
      child: Stack(
        children: [
          Container(
            height: 12,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 239, 226, 1),
              borderRadius: BorderRadius.circular(6),
            ),
            width: barWidth,
          ),
          AnimatedContainer(
            height: 12,
            duration: Duration(milliseconds: 250),
            curve: Curves.easeInOutCubic,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(6),
            ),
            width: progressWidth,
          ),
        ],
      ),
    );
  }
}
