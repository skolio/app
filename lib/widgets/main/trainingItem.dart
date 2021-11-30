import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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

class _TrainingListItemState extends State<TrainingListItem>
    with AutomaticKeepAliveClientMixin {
  bool _checkBoxValue = false;

  @override
  void initState() {
    super.initState();
    _checkBoxValue = authenticationBloc.currentUser.value.trainingPlan.contains(
      widget.trainingModel.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return InkWell(
      splashColor: Colors.transparent,
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
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: widget.trainingModel.imageURLs.first.contains("https:")
                ? CachedNetworkImageProvider(
                    widget.trainingModel.imageURLs.first,
                  )
                : widget.trainingModel.imageURLs.first.contains("/")
                    ? FileImage(File(widget.trainingModel.imageURLs.first))
                    : AssetImage(
                        "assets/images/${widget.trainingModel.imageURLs.first}",
                      ),
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
              height: 40,
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
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
