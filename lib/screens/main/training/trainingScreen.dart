import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:skolio/bloc/authenticationBloc.dart';
import 'package:skolio/bloc/trainingBloc.dart';
import 'package:skolio/model/trainingAudioModel.dart';
import 'package:skolio/model/trainingModel.dart';
import 'package:skolio/model/trainingModelInterface.dart';
import 'package:skolio/provider/audioProvider.dart';
import 'package:skolio/provider/volumeProvider.dart';
import 'package:skolio/screens/main/training/audioTraining/pauseScreen.dart';
import 'package:skolio/screens/main/training/finishedTrainingScreen.dart';
import 'package:skolio/widgets/main/training/ownProgressIndicator.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TrainingScreen extends StatefulWidget {
  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  StopWatchTimer _stopWatchTimer = StopWatchTimer();
  AudioProvider _audioProvider = AudioProvider();
  TrainingModelInterface _currentTraining;

  int _currentSet = 0;
  bool _lastTraining = false;
  bool _pause = false;
  int _pauseMinutes = 0;
  int _pauseSeconds = 0;
  Timer timer;

  @override
  void initState() {
    super.initState();
    volumeProvider.initProvider();

    _audioProvider.playerState.listen((event) {
      if (event == PlayerState.COMPLETED) {
        if (_currentTraining != null) {
          _audioProvider.stopPlayingAudio();
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
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _audioProvider.stopPlayingAudio();
  }

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

            TrainingModelInterface trainingModel =
                trainingBloc.fetchTrainingModel(trainingPlan.first);

            if (trainingPlan.length == 1) {
              _lastTraining = true;
            }

            _currentTraining = trainingModel;

            if (_currentTraining is TrainingAudioModel) {
              _audioProvider
                  .setURL((_currentTraining as TrainingAudioModel).mantraAudio);
              _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
              _stopWatchTimer.onExecute.add(StopWatchExecute.start);
              _audioProvider.playerState.first.then((value) {
                if (value != PlayerState.PLAYING) {
                  _audioProvider.togglePlayer();
                  _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                }
              });
            }

            if (_currentTraining is TrainingModel)
              return _getTrainingModelScreen();
            else
              return _getTrainingAudioModelScreen();
          }),
    );
  }

  _onTapCancel() {
    _audioProvider.stopPlayingAudio();
    timer?.cancel();
    Navigator.pop(context);
  }

  _onTapNext() async {
    _currentSet++;
    setState(() {});
    if (_currentSet == _currentTraining.repititions) {
      _audioProvider.stopPlayingAudio();
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
      if (_currentTraining is TrainingModel) {
        _pauseMinutes =
            (_currentTraining as TrainingModel).pauseBetween.inMinutes;
        _pauseSeconds =
            (_currentTraining as TrainingModel).pauseBetween.inSeconds;
      } else {
        _pauseMinutes = 0;
        _pauseSeconds = 0;
      }
      // setState(() {
      //   _pause = true;
      // });

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PauseScreen(),
        ),
      );
      // _startTime();
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

  _getTrainingModelScreen() {
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
                image: _currentTraining.imageURLs.first.contains("https:")
                    ? CachedNetworkImageProvider(
                        _currentTraining.imageURLs.first,
                      )
                    : _currentTraining.imageURLs.first.contains("/")
                        ? FileImage(File(_currentTraining.imageURLs.first))
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
          "${_currentSet.toString()}/${_currentTraining.repititions.toString()}",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10),
        OwnProgressIndicator(_currentSet, _currentTraining.repititions),
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
                      (_currentTraining as TrainingModel).description,
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
                                              : _pauseSeconds.toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "s",
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Theme.of(context).primaryColor,
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
                                        color: Theme.of(context).primaryColor,
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
                                      _currentTraining.repititions.toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Wiederholungen",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context).primaryColor,
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
  }

  _getTrainingAudioModelScreen() {
    TrainingAudioModel trainingAudioModel =
        _currentTraining as TrainingAudioModel;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 309,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 240, 227, 1),
                      ),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: _currentTraining.iconURL,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    StreamBuilder(
                      stream: volumeProvider.volumeStream,
                      builder: (context, snapshot) => Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: Icon(
                            snapshot.data == null || snapshot.data == 0
                                ? Icons.volume_off
                                : Icons.volume_up,
                          ),
                          onPressed: () {
                            volumeProvider.toggleVolume();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 70,
                  padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 240, 227, 1),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, size) {
                            var span = TextSpan(
                              text: _currentTraining.title,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            );

                            var tp = TextPainter(
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              textDirection: TextDirection.ltr,
                              text: span,
                            );

                            tp.layout(maxWidth: size.maxWidth);

                            var exceeded = tp.didExceedMaxLines;

                            if (!exceeded)
                              return Text(
                                _currentTraining.title,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                maxLines: 1,
                              );

                            return Marquee(
                              text: _currentTraining.title,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              blankSpace: 20.0,
                              velocity: 100.0,
                              pauseAfterRound: Duration(seconds: 1),
                              startPadding: 10.0,
                              accelerationDuration: Duration(seconds: 1),
                              accelerationCurve: Curves.linear,
                              decelerationDuration: Duration(milliseconds: 500),
                              decelerationCurve: Curves.easeOut,
                            );
                          },
                        ),
                      ),
                      StreamBuilder(
                        stream: _audioProvider.playerState,
                        builder: (context, snapshot) => snapshot.data == null
                            ? Container()
                            : InkWell(
                                child: Icon(
                                  snapshot.data == PlayerState.PLAYING
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 45,
                                ),
                                onTap: () async {
                                  _audioProvider.togglePlayer();
                                  final playerState =
                                      await _audioProvider.playerState.first;

                                  if (playerState == PlayerState.PLAYING) {
                                    _stopWatchTimer.onExecute
                                        .add(StopWatchExecute.start);
                                  } else {
                                    _stopWatchTimer.onExecute
                                        .add(StopWatchExecute.stop);
                                  }
                                },
                              ),
                      ),
                      Expanded(
                        child: Text(
                          _currentTraining.title,
                          style: TextStyle(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(),
          Text(
            "${_currentSet.toString()}/${_currentTraining.repititions.toString()}",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          OwnProgressIndicator(_currentSet, _currentTraining.repititions),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                if (trainingAudioModel.executionDescription.isNotEmpty)
                  _getTextField(
                    "Durchführung",
                    trainingAudioModel.executionDescription,
                  ),
                if (trainingAudioModel.cave.isNotEmpty)
                  _getTextField("CAVE", trainingAudioModel.cave),
              ],
            ),
          ),
          SizedBox(height: 20),
          StreamBuilder(
            stream: _stopWatchTimer.rawTime,
            builder: (context, snapshot) {
              if (snapshot.data == null)
                return Container(
                  child: Text(
                    "00:00",
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );

              String displayTime = StopWatchTimer.getDisplayTime(
                snapshot.data as int,
              );

              return Text(
                displayTime.substring(3, 8),
                style: TextStyle(
                  fontSize: 22,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
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
      ),
    );
  }

  _getTextField(String title, String text) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title + ":",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
