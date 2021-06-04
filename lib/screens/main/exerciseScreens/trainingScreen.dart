import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:skolio/bloc/authenticationBloc.dart';
import 'package:skolio/bloc/trainingBloc.dart';
import 'package:skolio/model/trainingModel.dart';
import 'package:skolio/model/userModel.dart';
import 'package:skolio/screens/main/exerciseScreens/trainingFinishedScreen.dart';

class TrainingScreen extends StatefulWidget {
  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  TrainingModel currentModel;
  int currentSet = 0;
  bool pause = false;
  int pauseMinutes = 0;
  int pauseSeconds = 0;
  Timer timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ÜBUNG"),
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: onTapCancel,
              child: Text(
                "Abbrechen",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: onTapNext,
              child: Text(
                "Weiter",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: authenticationBloc.currentUser,
        builder: (context, snapshot) {
          print("This is getting updated here");
          if (snapshot.data == null)
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );

          UserModel userModel = snapshot.data;

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

          if (trainingPlan.length == 0) return Container();
          TrainingModel trainingModel =
              trainingBloc.fetchTrainingModel(trainingPlan.first);

          currentModel = trainingModel;

          return Column(
            children: [
              SizedBox(height: 25),
              Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.3,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                  ),
                  items: trainingModel.imageURLs
                      .map(
                        (e) => Column(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 20, right: 20),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(e),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            trainingModel.imageTitle.length !=
                                    trainingModel.imageURLs.length
                                ? Container()
                                : Text(
                                    trainingModel.imageTitle[trainingModel
                                        .imageURLs
                                        .indexWhere((element) => element == e)],
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Text(
                  trainingModel.title,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Beschreibung",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        trainingModel.description,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                margin: EdgeInsets.only(right: 20),
                                child: Text(
                                  "Noch",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: pause
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(40),
                              child: Text(
                                pause
                                    ? pauseMinutes != 0
                                        ? "$pauseMinutes:$pauseSeconds"
                                        : pauseSeconds.toString()
                                    : trainingModel.repitions.toString(),
                                style: TextStyle(
                                  fontSize: pauseMinutes == 0 ? 40 : 50,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              child: Text(
                                "(Einheit ${currentSet.toString()}/${trainingModel.sets.toString()})",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        pause ? "Pause" : "Wiederholungen",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  onTapCancel() {
    Navigator.pop(context);
  }

  onTapNext() {
    if (pause) {
      timer?.cancel();
      setState(() {
        pause = false;
      });
      return;
    }
    currentSet++;
    if (currentSet == currentModel.sets) {
      authenticationBloc.addTrainingToStats(currentModel.id);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrainingFinishedScreen(),
        ),
      );
    } else {
      pauseMinutes = currentModel.pauseBetween.inMinutes;
      pauseSeconds = currentModel.pauseBetween.inSeconds;
      setState(() {
        pause = true;
      });
      startTime();
    }
  }

  startTime() {
    timer = new Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        pauseSeconds--;
      });
      if (pauseSeconds == 0) {
        if (pauseMinutes == 0) {
          timer.cancel();
          setState(() {
            pause = false;
          });
        } else {
          setState(() {
            pauseMinutes--;
            pauseSeconds = 60;
          });
        }
      } else {}
    });
  }
}
