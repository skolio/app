import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skolio/bloc/trainingBloc.dart';
import 'package:skolio/screens/main/training/audioTraining/newTrainingAudioScreen.dart';
import 'package:skolio/screens/main/training/newTrainingScreen.dart';
import 'package:skolio/widgets/main/training/trainingIconListItem.dart';

class TrainingPlanScreen extends StatefulWidget {
  @override
  _TrainingPlanScreenState createState() => _TrainingPlanScreenState();
}

class _TrainingPlanScreenState extends State<TrainingPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Trainingsplan",
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 50),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Text(
              "Wähle die Übungen für dein Training aus!",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: StreamBuilder(
                stream: trainingBloc.trainingList,
                builder: (context, snapshot) {
                  if (snapshot.data == null) return Container();
                  return DelayedDisplay(
                    delay: Duration(milliseconds: 250),
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 10),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) => TrainingIconListItem(
                        trainingModel: snapshot.data[index],
                        selected: true,
                        onTap: (newValue) {},
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 75,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewTrainingAudioScreen(null, null),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, size: 20),
                  SizedBox(width: 15),
                  Text("Neue Übung erstellen"),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
