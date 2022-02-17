import 'package:flutter/material.dart';

class OwnTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool obscure;
  final TextInputType textType;

  OwnTextField(
      {this.textEditingController,
      this.hintText,
      this.obscure = false,
      this.textType});

  @override
  _OwnTextFieldState createState() => _OwnTextFieldState();
}

class _OwnTextFieldState extends State<OwnTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 50,
            spreadRadius: 0,
            offset: Offset(0, 4),
            color: Color.fromRGBO(0, 0, 0, 0.03),
          ),
        ],
      ),
      padding: EdgeInsets.only(left: 20),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        obscureText: widget.obscure,
        decoration: InputDecoration(
          hintText: widget.hintText,
        ),
        keyboardType:
            widget.textType == null ? TextInputType.text : widget.textType,
        controller: widget.textEditingController,
      ),
    );
  }
}
