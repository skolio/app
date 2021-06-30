import 'package:flutter/material.dart';
import 'package:skolio/bloc/authenticationBloc.dart';
import 'package:skolio/bloc/trainingBloc.dart';
import 'package:skolio/screens/main/exerciseScreens/trainingLoadingScreen.dart';
import 'package:skolio/screens/main/exerciseScreens/trainingScreen.dart';
import 'package:skolio/widgets/main/trainingItem.dart';

class StartTrainingScreen extends StatefulWidget {
  final Function(int) changeCurrentScreen;

  StartTrainingScreen(this.changeCurrentScreen);

  @override
  _StartTrainingScreenState createState() => _StartTrainingScreenState();
}

class _StartTrainingScreenState extends State<StartTrainingScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authenticationBloc.currentUser,
      builder: (context, snapshot) {
        if (snapshot.data == null)
          return Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation(Theme.of(context).primaryColor),
            ),
          );

        List<String> trainingPlan = [];
        if (snapshot
                .data.statistic[DateTime.now().toString().split(" ").first] !=
            null)
          snapshot.data.trainingPlan.forEach((element) {
            if (!snapshot
                .data.statistic[DateTime.now().toString().split(" ").first]
                .contains(element)) trainingPlan.add(element);
          });
        else {
          trainingPlan = snapshot.data.trainingPlan;
        }

        if (trainingPlan.length == 0) {
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
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    "Du hast heute ${trainingPlan.length.toString()} Übungen auf dem Trainingsplan",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Expanded(
                  child: ListView.builder(
                    itemCount: trainingPlan.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          top: 20,
                          left: 20,
                          right: 20,
                        ),
                        child: TrainingListItem(
                          trainingBloc.fetchTrainingModel(
                            trainingPlan[index],
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
                    if (trainingPlan.length == 0) {
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
