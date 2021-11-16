import 'dart:io';
import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:skolio/bloc/authenticationBloc.dart';
import 'package:skolio/bloc/trainingBloc.dart';
import 'package:skolio/model/trainingModel.dart';
import 'package:skolio/screens/main/cameraScreen.dart';
import 'package:skolio/widgets/authentication/loadingDialog.dart';
import 'package:skolio/widgets/ownSnackBar.dart';

class NewTrainingScreen extends StatefulWidget {
  final TrainingModel trainingModel;
  final Function setState;

  NewTrainingScreen(this.trainingModel, this.setState);

  @override
  _NewTrainingScreenState createState() => _NewTrainingScreenState();
}

class _NewTrainingScreenState extends State<NewTrainingScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  int setCount = 0;
  int repititionCount = 0;
  String duration = "00:00";
  List<TextEditingController> imageTitles = [];

  List<String> images = [];

  @override
  void initState() {
    super.initState();
    if (widget.trainingModel != null) {
      _nameController.text = widget.trainingModel.title;
      _descriptionController.text = widget.trainingModel.description;

      setCount = widget.trainingModel.sets;
      repititionCount = widget.trainingModel.repitions;
      duration = widget.trainingModel.pauseBetween.inMinutes.toString() +
          ":" +
          widget.trainingModel.pauseBetween.inSeconds.toString();

      for (int i = 0; i < widget.trainingModel.imageURLs.length; i++) {
        imageTitles.add(
          TextEditingController(text: widget.trainingModel.imageTitle[i]),
        );
        images.add(widget.trainingModel.imageURLs[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ÜBUNG ERSTELLEN"),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: "Übungsname",
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: TextField(
                    controller: _descriptionController,
                    maxLines: 3,
                    minLines: 1,
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: "Übungsbeschreibung",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  items: List<Widget>.from(images.map(
                    (e) {
                      int index = images.indexOf(e);

                      return Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: e.contains("https")
                                              ? NetworkImage(e)
                                              : FileImage(File(e)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      images.removeAt(index);
                                      imageTitles.removeAt(index);
                                      setState(() {});
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 2,
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            spreadRadius: 2,
                                          ),
                                        ],
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      padding: EdgeInsets.all(5),
                                      child: Icon(
                                        Icons.clear,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextField(
                                controller: imageTitles[index],
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: "Bildtitel",
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList())
                    ..add(
                      InkWell(
                        onTap: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) => CupertinoActionSheet(
                              actions: [
                                CupertinoActionSheetAction(
                                  child: Text("Kamera"),
                                  onPressed: onTapCamera,
                                ),
                                CupertinoActionSheetAction(
                                  child: Text("Galerie"),
                                  onPressed: onTapAddImage,
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
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              "Wiederholungen",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  child: Icon(
                                    Icons.remove,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      if (setCount != 0) setCount--;
                                    });
                                  },
                                ),
                                Text(
                                  setCount.toString(),
                                  style: TextStyle(fontSize: 18),
                                ),
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  child: Icon(
                                    Icons.add,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      setCount++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              "Anzahl Einheiten",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  child: Icon(
                                    Icons.remove,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      if (repititionCount != 0)
                                        repititionCount--;
                                    });
                                  },
                                ),
                                Text(
                                  repititionCount.toString(),
                                  style: TextStyle(fontSize: 18),
                                ),
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  child: Icon(
                                    Icons.add,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      repititionCount++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: onTapDuration,
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          "Pausendauer",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Container(),
                              onPressed: null,
                            ),
                            Text(
                              duration,
                              style: TextStyle(fontSize: 18),
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Container(),
                              onPressed: null,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  child: Text("SPEICHERN"),
                  onPressed: onTapSave,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onTapSave() async {
    FocusScope.of(context).unfocus();
    if (_nameController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        images.length == 0 ||
        setCount == 0 ||
        duration == "00:00") {
      ScaffoldMessenger.of(context).showSnackBar(
        getSnackBar(context, "Es darf kein Feld leer sein"),
      );
      return;
    }

    TrainingModel trainingModel = TrainingModel.fromMap(
      {
        "id": widget.trainingModel != null ? widget.trainingModel.id : "",
        "uid": authenticationBloc.currentUser.valueOrNull.uid,
        "title": _nameController.text,
        "description": _descriptionController.text,
        "imageURLs": images,
        "imageTitle": imageTitles.map((e) => e.text).toList(),
        "sets": setCount,
        "repitions": repititionCount,
        "pauseBetween": "00:" + duration,
      },
    );

    showDialog(context: context, builder: (context) => LoadingDialog());

    var response;

    if (widget.trainingModel == null) {
      response = await trainingBloc.addOwnTraining(trainingModel);
    } else {
      response = await trainingBloc.editTraining(trainingModel);
      widget.setState(trainingModel);
    }

    Navigator.pop(context);

    if (response.code == "200") {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        getSnackBar(
          context,
          "Es ist ein Fehler aufgetreten bitte versuchen Sie es später erneut",
        ),
      );
    }
  }

  onTapAddImage() async {
    FocusScope.of(context).unfocus();
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
      allowCompression: true,
    );

    if (result != null) {
      imageTitles.clear();
      images = result.files.map((e) => e.path).toList();
      for (int i = 0; i < images.length; i++) {
        imageTitles.add(TextEditingController());
      }
      setState(() {});
    }
  }

  onTapCamera() async {
    final camera = await availableCameras();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraScreen(
          camera: camera.first,
          onImageTaken: (imagePath, imageName) async {
            images.add(imagePath);
            imageTitles.add(TextEditingController());
            setState(() {});
          },
        ),
      ),
    );
  }

  onTapDuration() {
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
                    duration = "$tempMinutes:$tempSeconds";
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

  Duration parseDuration(String s) {
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
