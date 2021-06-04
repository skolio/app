import 'package:flutter/material.dart';
import 'package:skolio/bloc/trainingBloc.dart';
import 'package:skolio/model/trainingModel.dart';
import 'package:skolio/screens/main/newTrainingScreen.dart';
import 'package:skolio/widgets/main/trainingItem.dart';

class TrainingsPlanScreen extends StatefulWidget {
  @override
  _TrainingsPlanScreenState createState() => _TrainingsPlanScreenState();
}

class _TrainingsPlanScreenState extends State<TrainingsPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
          ),
          child: StreamBuilder(
            stream: trainingBloc.trainingList,
            builder: (context, snapshot) => snapshot.data == null
                ? Center(child: CircularProgressIndicator())
                : snapshot.data.length == 0
                    ? Center(
                        child: Text(
                            "Es gibt noch keine Trainingsübungen zum auswählen"))
                    : ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.only(top: 20),
                          child: TrainingListItem(
                            snapshot.data[index],
                            null,
                            null,
                          ),
                        ),
                      ),

            // builder: (context, snapshot) => ListView(
            //   children: [
            //     SizedBox(height: 15),
            //     Text(
            //       "Wähle die Übungen für deinen individuellen Trainingsplan aus!",
            //       style: TextStyle(
            //         fontSize: 18,
            //         color: Colors.grey[800],
            //       ),
            //     ),
            //     SizedBox(height: 15),
            //     TrainingListItem(testTraining1, null),
            //     SizedBox(height: 20),
            //     TrainingListItem(testTraining2, null),
            //     SizedBox(height: 20),
            //   ],
            // ),
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
                    builder: (context) => NewTrainingScreen(),
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
