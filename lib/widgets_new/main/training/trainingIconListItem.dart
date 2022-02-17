import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skolio/bloc/authenticationBloc.dart';
import 'package:skolio/model/trainingModel.dart';
import 'package:skolio/screens_new/main/training/trainingInfoScreen.dart';

class TrainingIconListItem extends StatefulWidget {
  final TrainingModel trainingModel;
  final bool selected;
  final Function(bool) onTap;

  TrainingIconListItem({
    @required this.trainingModel,
    @required this.selected,
    @required this.onTap,
  });

  @override
  _TrainingIconListItemState createState() => _TrainingIconListItemState();
}

class _TrainingIconListItemState extends State<TrainingIconListItem> {
  bool _selected = false;

  @override
  void initState() {
    super.initState();
    _selected = authenticationBloc.currentUser.value.trainingPlan.contains(
      widget.trainingModel.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrainingInfoScreen(widget.trainingModel),
        ),
      ),
      child: AnimatedContainer(
        margin: EdgeInsets.only(bottom: 15),
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOutCubic,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _selected
                ? Theme.of(context).primaryColor
                : Color.fromRGBO(255, 239, 226, 1),
            width: 2,
          ),
          color: Color.fromRGBO(255, 239, 226, 1),
        ),
        height: 125,
        child: Row(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 250),
              curve: Curves.easeOut,
              width: 65,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(21),
                  bottomLeft: Radius.circular(21),
                ),
                color: _selected
                    ? Theme.of(context).primaryColor
                    : Color.fromRGBO(255, 239, 226, 1),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selected = !_selected;
                    if (_selected)
                      authenticationBloc
                          .addTrainingToPlan(widget.trainingModel.id);
                    else
                      authenticationBloc
                          .removeTrainingFromPlan(widget.trainingModel.id);
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeInOutCubic,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _selected
                          ? Colors.white
                          : Theme.of(context).textTheme.bodyText1.color,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  height: 25,
                  width: 25,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    curve: Curves.easeInOutCubic,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: _selected ? Colors.white : Colors.transparent,
                    ),
                    height: 15,
                    width: 15,
                  ),
                ),
              ),
            ),
            Container(
              width: 70,
              child: SvgPicture.asset(
                "assets/icons/meditate.svg",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  widget.trainingModel.title,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
