import 'package:flutter/material.dart';
import 'package:skolio/bloc/authenticationBloc.dart';
import 'package:skolio/model/trainingModel.dart';
import 'package:skolio/screens/main/trainingInfoScreen.dart';

class TrainingListItem extends StatefulWidget {
  final TrainingModel trainingModel;
  final Widget leftItem;
  final Widget actionButton;

  TrainingListItem(this.trainingModel, this.leftItem, this.actionButton);

  @override
  _TrainingListItemState createState() => _TrainingListItemState();
}

class _TrainingListItemState extends State<TrainingListItem> {
  bool _checkBoxValue = false;

  @override
  void initState() {
    super.initState();
    print(widget.trainingModel.id);
    print(widget.trainingModel == null);
    _checkBoxValue = authenticationBloc.currentUser.value.trainingPlan.contains(
      widget.trainingModel.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TrainingInfoScreen(widget.trainingModel),
          ),
        );
      },
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(widget.trainingModel.imageURLs.first),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20, top: 20),
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: widget.leftItem == null
                      ? Checkbox(
                          activeColor: Theme.of(context).primaryColor,
                          value: _checkBoxValue,
                          onChanged: (newValue) {
                            setState(() {
                              _checkBoxValue = !_checkBoxValue;
                              if (_checkBoxValue) {
                                authenticationBloc
                                    .addTrainingToPlan(widget.trainingModel.id);
                              } else {
                                authenticationBloc.removeTrainingFromPlan(
                                  widget.trainingModel.id,
                                );
                              }
                            });
                          },
                        )
                      : widget.leftItem,
                ),
              ),
            ),
            Container(
              height: 30,
              width: double.infinity,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Text(
                widget.trainingModel.title,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
