import 'package:flutter/material.dart';

class OwnTextField extends StatefulWidget {
  final bool obscureText;
  final Widget rightWidget;
  final TextEditingController controller;
  final String hintTitle;

  OwnTextField({
    this.controller,
    this.hintTitle,
    this.obscureText,
    this.rightWidget,
  });

  @override
  _OwnTextFieldState createState() => _OwnTextFieldState();
}

class _OwnTextFieldState extends State<OwnTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(244, 244, 244, 1),
      ),
      padding: EdgeInsets.only(
        left: 10,
        top: 5,
        bottom: 5,
        right: 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              obscureText: widget.obscureText,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintTitle,
              ),
            ),
          ),
          if (widget.rightWidget != null) widget.rightWidget
        ],
      ),
    );
  }
}
