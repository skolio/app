import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OverviewItem extends StatefulWidget {
  final String title;
  final Function onTap;

  OverviewItem({@required this.title, @required this.onTap});

  @override
  _OverviewItemState createState() => _OverviewItemState();
}

class _OverviewItemState extends State<OverviewItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
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
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              color: Theme.of(context).textTheme.bodyText1.color,
            ),
          ],
        ),
      ),
    );
  }
}
