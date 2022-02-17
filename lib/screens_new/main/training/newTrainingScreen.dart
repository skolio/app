import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skolio/bloc/authenticationBloc.dart';
import 'package:skolio/bloc/trainingBloc.dart';
import 'package:skolio/model/trainingModel.dart';
import 'package:skolio/screens/main/cameraScreen.dart';
import 'package:skolio/widgets/authentication/loadingDialog.dart';
import 'package:skolio/widgets/ownSnackBar.dart';

class NewTrainingScreen extends StatefulWidget {
  final TrainingModel trainingModel;
  final Function(TrainingModel) updateTrainingModel;

  NewTrainingScreen(this.trainingModel, this.updateTrainingModel);

  @override
  _NewTrainingScreenState createState() => _NewTrainingScreenState();
}

class _NewTrainingScreenState extends State<NewTrainingScreen> {
  int _sets = 0, _repititions = 1;
  Duration _pauseBetween = Duration(seconds: 15);
  bool _toCloud = true;
  String _duration = "00:15";
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<String> _imageURLs = [];

  @override
  initState() {
    super.initState();
    if (widget.trainingModel != null) {
      _titleController.text = widget.trainingModel.title;
      _descriptionController.text = widget.trainingModel.description;
      _sets = widget.trainingModel.sets;
      _repititions = widget.trainingModel.repitions;
      _imageURLs.addAll(widget.trainingModel.imageURLs);
      _duration = widget.trainingModel.pauseBetween.inMinutes.toString() +
          ":" +
          widget.trainingModel.pauseBetween.inSeconds.toString();
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
              CarouselSlider(
                items: [
                  ...List<Widget>.from(_imageURLs
                      .map(
                        (e) => Stack(
                          children: [
                            Container(
                              height: 177,
                              width: 309,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: e.contains("https:")
                                      ? CachedNetworkImageProvider(
                                          e,
                                        )
                                      : e.contains("/")
                                          ? FileImage(File(e))
                                          : AssetImage(
                                              "assets/images/$e",
                                            ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  _imageURLs.remove(e);
                                  setState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 2,
                                      ),
                                    ],
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  margin: EdgeInsets.only(right: 10, top: 10),
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList()),
                  InkWell(
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoActionSheet(
                          actions: [
                            CupertinoActionSheetAction(
                              child: Text("Kamera"),
                              onPressed: _onTapCamera,
                            ),
                            CupertinoActionSheetAction(
                              child: Text("Galerie"),
                              onPressed: _onTapAddImage,
                            ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            child: Text("Abbrechen"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 177,
                      width: 309,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Icon(Icons.add, size: 30),
                      ),
                    ),
                  ),
                ],
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  height: 177,
                ),
              ),
              SizedBox(height: 15),
              // Container(
              //   margin: EdgeInsets.only(left: 20),
              //   child: Row(
              //     children: [
              //       Row(
              //         children: [
              //           CupertinoButton(
              //             padding: EdgeInsets.zero,
              //             child: Icon(
              //               Icons.remove,
              //               color: Theme.of(context).textTheme.bodyText1.color,
              //             ),
              //             onPressed: () {
              //               FocusScope.of(context).unfocus();
              //               setState(() {
              //                 if (_sets != 0) _sets--;
              //               });
              //             },
              //           ),
              //           Text(
              //             _sets.toString(),
              //             style: TextStyle(fontSize: 18),
              //           ),
              //           CupertinoButton(
              //             padding: EdgeInsets.zero,
              //             child: Icon(
              //               Icons.add,
              //               color: Theme.of(context).textTheme.bodyText1.color,
              //             ),
              //             onPressed: () {
              //               FocusScope.of(context).unfocus();
              //               setState(() {
              //                 _sets++;
              //               });
              //             },
              //           ),
              //         ],
              //       ),
              //       SizedBox(width: 10),
              //       Text(
              //         "Sets",
              //         style: GoogleFonts.poppins(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w600,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 10),
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
                                "Wenn du deine Daten lokal in deinem Handy abspeicherst, gehen diese verloren, falls du dein Handy wechselst. Standardisiert werden deine Bilder sicher online gespeichert. Dadurch hast du auch bei einem Handywechsel stets Zugriff auf deine Daten."),
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
                            controller: _descriptionController,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(166, 166, 166, 1),
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Beschreibung",
                            ),
                          ),
                          Text(
                            // widget.trainingModel.description,
                            "",
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
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CupertinoButton(
                                            padding: EdgeInsets.zero,
                                            child: Icon(
                                              Icons.remove,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            onPressed: () {
                                              FocusScope.of(context).unfocus();
                                              setState(() {
                                                if (_repititions != 0)
                                                  _repititions--;
                                              });
                                            },
                                          ),
                                          Text(
                                            _repititions.toString(),
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          CupertinoButton(
                                            padding: EdgeInsets.zero,
                                            child: Icon(
                                              Icons.add,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            onPressed: () {
                                              FocusScope.of(context).unfocus();
                                              setState(() {
                                                _repititions++;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Wiederholungen",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Container(
                                //   margin: EdgeInsets.only(top: 10, bottom: 10),
                                //   width: 2,
                                //   height: 200,
                                //   decoration: BoxDecoration(
                                //     color: Colors.black.withOpacity(0.2),
                                //   ),
                                // ),
                                // Expanded(
                                //   child: GestureDetector(
                                //     onTap: _onTapDuration,
                                //     child: Column(
                                //       mainAxisSize: MainAxisSize.min,
                                //       children: [
                                //         Row(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.center,
                                //           children: [
                                //             CupertinoButton(
                                //               padding: EdgeInsets.zero,
                                //               child: Container(),
                                //               onPressed: null,
                                //             ),
                                //             Text(
                                //               _duration,
                                //               style: TextStyle(
                                //                 fontSize: 18,
                                //                 color: Theme.of(context)
                                //                     .primaryColor,
                                //               ),
                                //             ),
                                //             CupertinoButton(
                                //               padding: EdgeInsets.zero,
                                //               child: Container(),
                                //               onPressed: null,
                                //             ),
                                //           ],
                                //         ),
                                //         Text(
                                //           "Pause",
                                //           style: TextStyle(
                                //             fontSize: 14,
                                //             color:
                                //                 Theme.of(context).primaryColor,
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
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

  _onTapSave() async {
    FocusScope.of(context).unfocus();

    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _duration == "00:00") {
      ScaffoldMessenger.of(context).showSnackBar(
        getSnackBar(context, "Es darf kein Feld leer sein"),
      );
      return;
    }

    TrainingModel trainingModel = TrainingModel.fromMap(
      {
        "id": widget.trainingModel != null ? widget.trainingModel.id : "",
        "uid": authenticationBloc.currentUser.valueOrNull.uid,
        "title": _titleController.text,
        "description": _descriptionController.text,
        "imageURLs": _imageURLs,
        "sets": _sets,
        "repitions": _repititions,
        "pauseBetween": "00:" + _duration,
      },
    );

    trainingModel.editable = true;

    if (widget.updateTrainingModel != null) {
      widget.updateTrainingModel(trainingModel);
    }

    showDialog(context: context, builder: (context) => LoadingDialog());

    var response;

    if (widget.trainingModel == null) {
      response = await trainingBloc.addOwnTraining(trainingModel, !_toCloud);
    } else {
      response = await trainingBloc.editTraining(trainingModel, !_toCloud);
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

  _onTapAddImage() async {
    FocusScope.of(context).unfocus();
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
      allowCompression: true,
    );

    if (result != null) {
      _imageURLs = result.files.map((e) => e.path).toList();
      setState(() {});
    }
    Navigator.pop(context);
  }

  _onTapCamera() async {
    final camera = await availableCameras();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraScreen(
          camera: camera.first,
          onImageTaken: (imagePath, imageName) async {
            _imageURLs.add(imagePath);
            setState(() {});
          },
        ),
      ),
    );
    Navigator.pop(context);
  }

  _onTapDuration() {
    FocusScope.of(context).unfocus();

    String tempMinutes = "0";
    String tempSeconds = "0";

    Picker(
      adapter: NumberPickerAdapter(
        data: [
          NumberPickerColumn(begin: 00, end: 60),
          NumberPickerColumn(begin: 00, end: 60),
        ],
      ),
      hideHeader: false,
      builderHeader: (context) => Container(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 5),
                CupertinoButton(
                  child: Text(
                    "Zurück",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
                CupertinoButton(
                  child: Text(
                    "Bestätigen",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _duration = "$tempMinutes:$tempSeconds";
                    setState(() {});
                  },
                ),
                SizedBox(width: 5),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      "Minuten",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Sekunden",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onSelect: (picker, _, items) {
        final minutes = items[0].toString();
        tempMinutes = minutes.length == 1 ? "0$minutes" : minutes;

        final seconds = items[1].toString();
        tempSeconds = seconds.length == 1 ? "0$seconds" : seconds;
      },
      confirm: Text("Bestätigen"),
      title: Text("Dauer auswählen"),
      onConfirm: (Picker picker, List value) {},
    ).showModal(context);
  }

  Duration _parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }
}
