import 'package:flutter/material.dart';
import 'package:skolio/bloc/trainingBloc.dart';
import 'package:skolio/model/trainingModel.dart';
import 'package:skolio/screens/main/newTrainingScreen.dart';
import 'package:skolio/widgets/main/trainingItem.dart';

class ReordableTrainingPlanScreen extends StatefulWidget {
  @override
  _ReordableTrainingPlanScreenState createState() =>
      _ReordableTrainingPlanScreenState();
}

class _ReordableTrainingPlanScreenState
    extends State<ReordableTrainingPlanScreen> {
  final List<TrainingModel> trainingPlan = [];

  @override
  void initState() {
    super.initState();
    print(trainingBloc.trainingList.valueOrNull.length);
    trainingPlan.addAll(trainingBloc.trainingList.valueOrNull);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
          ),
          child: trainingPlan.length == 0
              ? Center(
                  child:
                      Text("Es gibt noch keine Trainingsübungen zum auswählen"),
                )
              : ReorderableListView.builder(
                  itemCount: trainingPlan.length,
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    margin: EdgeInsets.only(top: 20),
                    key: Key(trainingPlan[index].id),
                    child: TrainingListItem(
                      trainingPlan[index],
                      null,
                      null,
                    ),
                  ),
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final TrainingModel item =
                          trainingPlan.removeAt(oldIndex);
                      trainingPlan.insert(newIndex, item);
                      trainingBloc.changeTrainingListOrder(
                        List<String>.from(
                            trainingPlan.map((e) => e.id).toList()),
                      );
                    });
                  },
                ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: EdgeInsets.only(
              right: 30,
              bottom: 50,
            ),
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.add,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewTrainingScreen(null, null),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
