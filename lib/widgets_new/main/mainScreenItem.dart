import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainScreenItem extends StatefulWidget {
  final String title;
  final String description;
  final String icon;

  MainScreenItem({this.title, this.description, this.icon});

  @override
  _MainScreenItemState createState() => _MainScreenItemState();
}

class _MainScreenItemState extends State<MainScreenItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21),
        color: Color.fromRGBO(255, 239, 226, 1),
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Expanded(
            child: Center(
              child: Image.asset(
                widget.icon,
              ),
            ),
          ),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              widget.description,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
