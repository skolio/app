import 'package:flutter/material.dart';

class InfoDialog extends StatefulWidget {
  @override
  _InfoDialogState createState() => _InfoDialogState();
}

class _InfoDialogState extends State<InfoDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: Column(
          children: [
            Container(
              child: Text(
                "Skolio ist eine Anwendung zur Unterstützung Deiner Skoliose-Therapie. Das Training mit Skolio sollte nur nach Anleitung durch einen geschulten Therapeuten erfolgen.",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        ),
      ),
    );
  }
}
