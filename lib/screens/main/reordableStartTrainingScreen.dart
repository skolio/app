import 'package:flutter/material.dart';
import 'package:skolio/bloc/authenticationBloc.dart';
import 'package:skolio/bloc/trainingBloc.dart';
import 'package:skolio/screens/main/exerciseScreens/trainingLoadingScreen.dart';
import 'package:skolio/screens/main/exerciseScreens/trainingScreen.dart';
import 'package:skolio/widgets/main/trainingItem.dart';

class ReordableStartTrainingScreen extends StatefulWidget {
  final Function(int) changeCurrentScreen;

  ReordableStartTrainingScreen(this.changeCurrentScreen);

  @override
  _ReordableStartTrainingScreenState createState() =>
      _ReordableStartTrainingScreenState();
}

class _ReordableStartTrainingScreenState
    extends State<ReordableStartTrainingScreen> {
  final List<String> _trainingPlan = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: authenticationBloc.currentUser.valueOrNull,
      stream: authenticationBloc.currentUser,
      builder: (context, snapshot) {
        if (snapshot.data == null)
          return Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation(Theme.of(context).primaryColor),
            ),
          );

        _trainingPlan.clear();

        if (snapshot
                .data.statistic[DateTime.now().toString().split(" ").first] !=
            null)
          snapshot.data.trainingPlan.forEach((element) {
            if (!snapshot
                .data.statistic[DateTime.now().toString().split(" ").first]
                .contains(element)) _trainingPlan.add(element);
          });
        else {
          _trainingPlan.addAll(snapshot.data.trainingPlan);
        }

        if (_trainingPlan.length == 0) {
          return Center(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "Du hast für heute keine Übungen geplant.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "Du hast heute ${_trainingPlan.length.toString()} Übungen auf dem Trainingsplan",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: ReorderableListView.builder(
                      itemCount: _trainingPlan.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(10),
                          key: Key(_trainingPlan[index]),
                          child: TrainingListItem(
                            trainingBloc.fetchTrainingModel(
                              _trainingPlan[index],
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                (index + 1).toString(),
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Container(),
                          ),
                        );
                      },
                      onReorder: (oldIndex, newIndex) {
                        setState(() {
                          final listItem = _trainingPlan.removeAt(oldIndex);
                          _trainingPlan.insert(newIndex, listItem);
                          authenticationBloc
                              .setOrderOfTrainingPlan(_trainingPlan);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(180, 40),
                    primary: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    "TRAINING STARTEN",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    if (_trainingPlan.length == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(""),
                        ),
                      );
                      return;
                    }

                    if (snapshot.data.statistic[DateTime.now().toString()] !=
                        null) {
                      if (snapshot.data.statistic[DateTime.now().toString()]
                              .length ==
                          snapshot.data.trainingPlan.length) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "Die heutigen Übungen wurden schon erledigt"),
                          ),
                        );
                        return;
                      }
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FutureBuilder(
                          future: () async {
                            await Future.delayed(Duration(seconds: 2));
                            return "Finished";
                          }(),
                          builder: (context, snapshot) => snapshot.data == null
                              ? TrainingLoadingScreen()
                              : TrainingScreen(widget.changeCurrentScreen),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
