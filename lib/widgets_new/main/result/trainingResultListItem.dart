import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skolio/model/trainingModel.dart';

class TrainingResultListItem extends StatefulWidget {
  final TrainingModel trainingModel;

  TrainingResultListItem({this.trainingModel});

  @override
  _TrainingResultListItemState createState() => _TrainingResultListItemState();
}

class _TrainingResultListItemState extends State<TrainingResultListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.33,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
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
      child: Column(
        children: [
          Row(
            children: [],
          ),
          Row(
            children: [
              SvgPicture.asset("assets/icons/greenCheck.svg"),
              Text("Übung abgeschlossen"),
            ],
          ),
        ],
      ),
    );
  }
}
