import 'package:flutter/material.dart';
import 'package:skolio/bloc/trainingBloc.dart';
import 'package:skolio/model/trainingModel.dart';
import 'package:skolio/widgets/main/trainingItem.dart';

class StartTrainingScreen extends StatefulWidget {
  @override
  _StartTrainingScreenState createState() => _StartTrainingScreenState();
}

class _StartTrainingScreenState extends State<StartTrainingScreen> {
  final testTraining1 = TrainingModel(
    {
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
  final testTraining2 = TrainingModel(
    {
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
    return StreamBuilder(
      stream: trainingBloc.trainingList,
      builder: (context, snapshot) => snapshot.data == null
          ? Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(Theme.of(context).primaryColor),
              ),
            )
          : Stack(
              children: [
                ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                    ),
                    child: TrainingListItem(
                      testTraining1,
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
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
                        "STARTEN",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        print("Something is going on here");
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
