import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailVerificationDialog extends StatefulWidget {
  @override
  EmailVerificationDialogState createState() => EmailVerificationDialogState();
}

class EmailVerificationDialogState extends State<EmailVerificationDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "Vielen Dank für deine Registrierung bei Skolio. Wir haben die eine E-Mail geschickt. Bitte verifiziere deine E-Mailadresse und logge dich danach bei Skolio ein.",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Bestätigen"),
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
