import 'package:flutter/material.dart';

SnackBar getSnackBar(BuildContext context, String text) {
  return SnackBar(
    backgroundColor: Theme.of(context).primaryColor,
    content: Text(
      text,
      style: TextStyle(color: Colors.white),
    ),
  );
}
