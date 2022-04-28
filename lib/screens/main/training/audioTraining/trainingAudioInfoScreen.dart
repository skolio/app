import 'package:audioplayers/audioplayers_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:skolio/bloc/trainingBloc.dart';
import 'package:skolio/model/trainingAudioModel.dart';
import 'package:skolio/provider/audioProvider.dart';
import 'package:skolio/provider/volumeProvider.dart';

class TrainingAudioInfoScreen extends StatefulWidget {
  final TrainingAudioModel trainingAudioModel;

  TrainingAudioInfoScreen(this.trainingAudioModel);

  @override
  _TrainingAudioInfoScreenState createState() =>
      _TrainingAudioInfoScreenState();
}

class _TrainingAudioInfoScreenState extends State<TrainingAudioInfoScreen> {
  AudioProvider _audioProvider = AudioProvider();
  int repitition;

  @override
  void initState() {
    super.initState();
    repitition = widget.trainingAudioModel.repititions;
    volumeProvider.initProvider();
    _audioProvider.setURL(widget.trainingAudioModel.executionAudio);
  }

  @override
  dispose() {
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
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Stack(
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
                                imageUrl: widget.trainingAudioModel.iconURL,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          StreamBuilder(
                            stream: volumeProvider.volumeStream,
                            builder: (context, snapshot) =>
                                snapshot.data == null
                                    ? Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          icon: Icon(Icons.volume_off),
                                          onPressed: () {
                                            volumeProvider.toggleVolume();
                                          },
                                        ),
                                      )
                                    : Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          icon: Icon(
                                            snapshot.data == 0
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
                                  text: widget.trainingAudioModel.title,
                                  style: TextStyle(
                                    fontSize: 18,
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
                                    widget.trainingAudioModel.title,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  );

                                return Marquee(
                                  text: widget.trainingAudioModel.title,
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
                                  decelerationDuration:
                                      Duration(milliseconds: 500),
                                  decelerationCurve: Curves.easeOut,
                                );
                              },
                            ),
                          ),
                          StreamBuilder(
                            stream: _audioProvider.playerState,
                            builder: (context, snapshot) =>
                                snapshot.data == null
                                    ? Container()
                                    : InkWell(
                                        child: Icon(
                                          snapshot.data == PlayerState.PLAYING
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          size: 45,
                                        ),
                                        onTap: () {
                                          _audioProvider.togglePlayer();
                                        },
                                      ),
                          ),
                          Expanded(
                            child: Text(
                              widget.trainingAudioModel.title,
                              style: TextStyle(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              "Anzahl Einheiten",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      if (repitition != 1) repitition--;
                                    });
                                  },
                                ),
                                SizedBox(width: 20),
                                Container(
                                  child: Text(
                                    repitition.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      repitition++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    getTitleTextField(
                      "Ziel der Übung",
                      widget.trainingAudioModel.goalOfExercise,
                    ),
                    getTitleTextField(
                      "Ausgangstellung",
                      widget.trainingAudioModel.startingPosition,
                    ),
                    getTitleTextField(
                      "Durchführung",
                      widget.trainingAudioModel.executionDescription,
                    ),
                    getTitleTextField(
                      "Hilfsmittel",
                      widget.trainingAudioModel.tools,
                    ),
                    getTitleTextField(
                      "CAVE",
                      widget.trainingAudioModel.cave,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            if (widget.trainingAudioModel.editable)
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
                  child: Text("Bearbeiten"),
                  onPressed: () {
                    //TODO go to the NewTrainingModel Screen
                  },
                ),
              ),
            SizedBox(height: 10),
            if (widget.trainingAudioModel.editable)
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
                    "Löschen",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onPressed: () {
                    trainingBloc.deleteTraining(widget.trainingAudioModel.id);
                    Navigator.pop(context);
                  },
                ),
              ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  getTitleTextField(String title, String text) {
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
