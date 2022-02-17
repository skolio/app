import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skolio/bloc/authenticationBloc.dart';
import 'package:skolio/bloc/trainingBloc.dart';
import 'package:skolio/model/trainingModel.dart';
import 'package:skolio/screens_new/main/training/finishedTrainingScreen.dart';
import 'package:skolio/widgets_new/main/training/ownProgressIndicator.dart';

class TrainingScreen extends StatefulWidget {
  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  TrainingModel _currentTraining;

  int _currentSet = 0;
  bool _lastTraining = false;
  bool _pause = false;
  int _pauseMinutes = 0;
  int _pauseSeconds = 0;
  Timer timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Übung",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyText1.color,
            fontSize: 16,
          ),
        ),
      ),
      body: StreamBuilder(
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

            List<String> trainingPlan = [];

            if (snapshot.data
                    .statistic[DateTime.now().toString().split(" ").first] !=
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

            if (trainingPlan.length == 1) {
              _lastTraining = true;
            }

            _currentTraining = trainingModel;

            return Column(
              children: [
                SizedBox(height: 20),
                CarouselSlider.builder(
                  itemCount: _currentTraining.imageURLs.length,
                  itemBuilder: (context, index, index2) => Container(
                    height: 177,
                    width: 309,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image:
                            _currentTraining.imageURLs.first.contains("https:")
                                ? CachedNetworkImageProvider(
                                    _currentTraining.imageURLs.first,
                                  )
                                : _currentTraining.imageURLs.first.contains("/")
                                    ? FileImage(
                                        File(_currentTraining.imageURLs.first))
                                    : AssetImage(
                                        "assets/images/${_currentTraining.imageURLs.first}",
                                      ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    height: 177,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "${_currentSet.toString()}/${_currentTraining.repitions.toString()}",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                OwnProgressIndicator(_currentSet, _currentTraining.repitions),
                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 50,
                              spreadRadius: 0,
                              offset: Offset(0, 4),
                              color: Color.fromRGBO(0, 0, 0, 0.03),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _currentTraining.title,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              _currentTraining.description,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(166, 166, 166, 1),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 2,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(244, 244, 244, 1),
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              height: 127,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 239, 226, 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: _pause
                                  ? Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  _pauseMinutes != 0
                                                      ? "$_pauseMinutes:$_pauseSeconds"
                                                      : _pauseSeconds
                                                          .toString(),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 28,
                                                    fontWeight: FontWeight.w700,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                                Text(
                                                  "s",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "Pause",
                                              style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            child: Text(
                                              _currentTraining.repitions
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                fontSize: 28,
                                                fontWeight: FontWeight.w700,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "Wiederholungen",
                                              style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 66,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text("Weiter"),
                    onPressed: _onTapNext,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 66,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    child: Text(
                      "Abbrechen",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: _onTapCancel,
                  ),
                ),
                SizedBox(height: 30),
              ],
            );
          }),
    );
  }

  _onTapCancel() {
    timer?.cancel();
    Navigator.pop(context);
  }

  _onTapNext() {
    if (_pause) {
      timer?.cancel();
      setState(() {
        _pause = false;
      });
      return;
    }
    _currentSet++;
    if (_currentSet == _currentTraining.repitions) {
      authenticationBloc.addTrainingToStats(_currentTraining.id);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FinishedTrainingScreen(
            finishedTrainingPlan: _lastTraining,
          ),
        ),
      );
    } else {
      _pauseMinutes = _currentTraining.pauseBetween.inMinutes;
      _pauseSeconds = _currentTraining.pauseBetween.inSeconds;
      setState(() {
        _pause = true;
      });
      _startTime();
    }
  }

  _startTime() {
    timer = new Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _pauseSeconds--;
      });
      if (_pauseSeconds == 0) {
        if (_pauseMinutes == 0) {
          timer.cancel();
          setState(() {
            _pause = false;
          });
        } else {
          setState(() {
            _pauseMinutes--;
            _pauseSeconds = 60;
          });
        }
      } else {}
    });
  }
}
