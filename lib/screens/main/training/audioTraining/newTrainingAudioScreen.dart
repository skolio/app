import 'package:audioplayers/audioplayers_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skolio/bloc/trainingBloc.dart';
import 'package:skolio/model/trainingAudioModel.dart';
import 'package:skolio/model/trainingModelInterface.dart';
import 'package:skolio/provider/audioProvider.dart';
import 'package:skolio/widgets/authentication/loadingDialog.dart';
import 'package:skolio/widgets/ownSnackBar.dart';

class NewTrainingAudioScreen extends StatefulWidget {
  final TrainingAudioModel trainingAudioModel;
  final Function(TrainingAudioModel) updateTrainingModel;

  NewTrainingAudioScreen(this.trainingAudioModel, this.updateTrainingModel);

  @override
  _NewTrainingAudioScreenState createState() => _NewTrainingAudioScreenState();
}

class _NewTrainingAudioScreenState extends State<NewTrainingAudioScreen> {
  final _audioProvider = AudioProvider();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _goalOfExerciseController =
      TextEditingController();
  final TextEditingController _startingPositionController =
      TextEditingController();
  final TextEditingController _executionDescriptionController =
      TextEditingController();
  final TextEditingController _toolsController = TextEditingController();
  final TextEditingController _caveController = TextEditingController();

  String _executionAudio;
  String _mantraAudio;
  String _startingPositionAudio;
  String _iconImage;

  bool _toCloud = true;

  int _currentlyPlaying = 0;

  @override
  void initState() {
    super.initState();
    if (widget.trainingAudioModel != null) {
      _titleController.text = widget.trainingAudioModel.title;
      _goalOfExerciseController.text = widget.trainingAudioModel.goalOfExercise;
      _startingPositionController.text =
          widget.trainingAudioModel.startingPosition;
      _executionDescriptionController.text =
          widget.trainingAudioModel.executionDescription;
      _toolsController.text = widget.trainingAudioModel.tools;
      _caveController.text = widget.trainingAudioModel.cave;

      _executionAudio = widget.trainingAudioModel.executionAudio;
      _mantraAudio = widget.trainingAudioModel.mantraAudio;
      _startingPositionAudio = widget.trainingAudioModel.startingPositionAudio;

      _iconImage = widget.trainingAudioModel.iconURL;
    }
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              kToolbarHeight,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                height: 177,
                width: 309,
                child: InkWell(
                  onTap: _onTapIcon,
                  child: _iconImage == null
                      ? Center(
                          child: Icon(
                            Icons.add,
                            size: 35,
                          ),
                        )
                      : _iconImage.contains("http://")
                          ? Image.network(_iconImage)
                          : Image.asset(_iconImage),
                ),
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _toCloud = !_toCloud;
                        setState(() {});
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        curve: Curves.easeInOutCubic,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _toCloud
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).textTheme.bodyText1.color,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        height: 25,
                        width: 25,
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 250),
                          curve: Curves.easeInOutCubic,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: _toCloud
                                ? Theme.of(context).primaryColor
                                : Colors.transparent,
                          ),
                          height: 15,
                          width: 15,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Lokal im Handy speichern?",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.info,
                        color: Theme.of(context).textTheme.bodyText1.color,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Deine Daten"),
                            content: Text(
                              "Wenn du deine Daten lokal in deinem Handy abspeicherst, gehen diese verloren, falls du dein Handy wechselst. Standardisiert werden deine Bilder sicher online gespeichert. Dadurch hast du auch bei einem Handywechsel stets Zugriff auf deine Daten.",
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
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
                          TextField(
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                            ),
                            controller: _titleController,
                            decoration: InputDecoration(
                              hintText: "Titel",
                              isDense: true,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            maxLines: 3,
                            controller: _goalOfExerciseController,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(166, 166, 166, 1),
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Ziel der Übung",
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            maxLines: 3,
                            controller: _startingPositionController,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(166, 166, 166, 1),
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Ausgangsstellung",
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            maxLines: 3,
                            controller: _executionDescriptionController,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(166, 166, 166, 1),
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Durchführung",
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            maxLines: 3,
                            controller: _toolsController,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(166, 166, 166, 1),
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Hilfsmittel",
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            maxLines: 3,
                            controller: _caveController,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(166, 166, 166, 1),
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "CAVE",
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  "Ausgangstellung Audio",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  child: Icon(
                                    _startingPositionAudio == null
                                        ? Icons.add
                                        : Icons.edit,
                                  ),
                                  onTap: () => _onTapAddAudio(0),
                                ),
                                SizedBox(width: 10),
                                StreamBuilder(
                                  stream: _audioProvider.playerState,
                                  builder: (context, snapshot) => snapshot
                                              .data ==
                                          null
                                      ? InkWell(
                                          child: Icon(Icons.play_arrow),
                                          onTap: () {
                                            if (_startingPositionAudio == null)
                                              return;
                                            if (_currentlyPlaying != 0)
                                              _audioProvider.setURL(
                                                _startingPositionAudio,
                                              );
                                          },
                                        )
                                      : snapshot.data == PlayerState.PLAYING &&
                                              _currentlyPlaying == 0
                                          ? InkWell(
                                              onTap: () {
                                                _audioProvider.togglePlayer();
                                              },
                                              child: Icon(Icons.pause),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                if (_startingPositionAudio ==
                                                    null) return;
                                                if (_currentlyPlaying != 0)
                                                  _audioProvider.setURL(
                                                    _startingPositionAudio,
                                                  );

                                                _audioProvider.togglePlayer();
                                              },
                                              child: Icon(Icons.play_arrow),
                                            ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  "Übungsdurchführung Audio",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  child: Icon(
                                    _executionAudio == null
                                        ? Icons.add
                                        : Icons.edit,
                                  ),
                                  onTap: () => _onTapAddAudio(1),
                                ),
                                SizedBox(width: 10),
                                StreamBuilder(
                                  stream: _audioProvider.playerState,
                                  builder: (context, snapshot) => snapshot
                                              .data ==
                                          null
                                      ? InkWell(
                                          child: Icon(Icons.play_arrow),
                                          onTap: () {
                                            if (_startingPositionAudio == null)
                                              return;
                                            if (_currentlyPlaying != 0)
                                              _audioProvider.setURL(
                                                _startingPositionAudio,
                                              );
                                          },
                                        )
                                      : snapshot.data == PlayerState.PLAYING &&
                                              _currentlyPlaying == 0
                                          ? InkWell(
                                              onTap: () {
                                                _audioProvider.togglePlayer();
                                              },
                                              child: Icon(Icons.pause),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                if (_currentlyPlaying != 0)
                                                  _audioProvider
                                                      .setURL(_executionAudio);

                                                _audioProvider.togglePlayer();
                                              },
                                              child: Icon(Icons.play_arrow),
                                            ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  "Mantra Audio",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  child: Icon(
                                    _mantraAudio == null
                                        ? Icons.add
                                        : Icons.edit,
                                  ),
                                  onTap: () => _onTapAddAudio(2),
                                ),
                                SizedBox(width: 10),
                                StreamBuilder(
                                  stream: _audioProvider.playerState,
                                  builder: (context, snapshot) => snapshot
                                              .data ==
                                          null
                                      ? InkWell(
                                          child: Icon(Icons.play_arrow),
                                          onTap: () {
                                            if (_startingPositionAudio == null)
                                              return;
                                            if (_currentlyPlaying != 0)
                                              _audioProvider.setURL(
                                                _startingPositionAudio,
                                              );
                                          },
                                        )
                                      : snapshot.data == PlayerState.PLAYING &&
                                              _currentlyPlaying == 0
                                          ? InkWell(
                                              onTap: () {
                                                _audioProvider.togglePlayer();
                                              },
                                              child: Icon(Icons.pause),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                if (_currentlyPlaying != 0)
                                                  _audioProvider
                                                      .setURL(_mantraAudio);

                                                _audioProvider.togglePlayer();
                                              },
                                              child: Icon(Icons.play_arrow),
                                            ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                  child: Text("Speichern"),
                  onPressed: _onTapSave,
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  _onTapIcon() async {
    FocusScope.of(context).unfocus();
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
      allowCompression: true,
    );

    if (result != null) {
      _iconImage = result.files.first.path;
      setState(() {});
    }
  }

  getTextField(String title, TextEditingController controller) {
    return Container();
  }

  _onTapSave() async {
    if (_titleController.text.isEmpty ||
        _goalOfExerciseController.text.isEmpty ||
        _startingPositionController.text.isEmpty ||
        _executionDescriptionController.text.isEmpty ||
        _toolsController.text.isEmpty ||
        _caveController.text.isEmpty ||
        _iconImage.isEmpty ||
        _executionAudio.isEmpty ||
        _startingPositionAudio.isEmpty ||
        _mantraAudio.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Es müssen alle Felder ausgefüllt sein"),
        ),
      );
    }

    TrainingAudioModel trainingAudioModel = TrainingAudioModel.fromMap({
      "id":
          widget.trainingAudioModel != null ? widget.trainingAudioModel.id : "",
      "uid": widget.trainingAudioModel != null
          ? widget.trainingAudioModel.uid
          : "",
      "title": _titleController,
      "iconURL": _iconImage,
      "imageURLs": [],
      "repititions": 3,
      "editable": true,
      "goalOfExercises": _goalOfExerciseController.text,
      "startingPosition": _startingPositionController.text,
      "executionDescription": _executionDescriptionController.text,
      "tools": _toolsController.text,
      "cave": _caveController.text,
      "executionAudio": _executionAudio,
      "startingPositionAudio": _startingPositionAudio,
      "mantraAudio": _mantraAudio,
    });

    if (widget.updateTrainingModel != null) {
      widget.updateTrainingModel(trainingAudioModel);
    }

    showDialog(context: context, builder: (context) => LoadingDialog());

    var response;

    if (widget.trainingAudioModel == null) {
      response = await trainingBloc.addOwnTraining(
        trainingAudioModel,
        !_toCloud,
      );
    } else {
      response = await trainingBloc.editTraining(trainingAudioModel, !_toCloud);
    }

    Navigator.pop(context);

    if (response.code == "200") {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        getSnackBar(
          context,
          "Es ist ein Fehler aufgetreten bitte versuche es erneut",
        ),
      );
    }
  }

  _onTapAddAudio(int index) async {
    print("We are here");
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.audio,
      allowCompression: true,
    );

    if (result != null) {
      switch (index) {
        case 0:
          _startingPositionAudio = result.files.first.path;
          break;
        case 1:
          _executionAudio = result.files.first.path;
          break;
        case 2:
          _mantraAudio = result.files.first.path;
          break;
      }
    }
  }
}
