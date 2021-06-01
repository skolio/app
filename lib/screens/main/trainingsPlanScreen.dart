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
  final testTraining1 = TrainingModel.fromMap(
    {
      "id": "1",
      "title": "Test Übung 1",
      "description": "- TestTeil 1\n"
          "- TestTeil 2\n"
          "- TestTeil 3\n"
          "- TestTeil 4\n",
      "imageURLs": [
        "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8d29ya2luZyUyMG91dHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
        "https://images.unsplash.com/photo-1585484764802-387ea30e8432?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fHdvcmtpbmclMjBvdXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
        "https://images.unsplash.com/photo-1534438327276-14e5300c3a48?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Z3ltfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
      ],
      "imageTitle": [
        "FirstImage",
        "SecondImage",
        "ThirdImage",
      ],
      "duration": Duration(seconds: 30).toString(),
    },
  );
  final testTraining2 = TrainingModel.fromMap(
    {
      "id": "1",
      "title": "Test Übung 2",
      "description": "- TestTeil 2.1\n"
          "- TestTeil 2.2\n"
          "- TestTeil 2.3\n"
          "- TestTeil 2.4\n",
      "imageURLs": [],
      "imageTitle": [],
      "duration": Duration(seconds: 30).toString(),
    },
  );

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
