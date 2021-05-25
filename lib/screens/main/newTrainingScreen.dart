import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:skolio/widgets/ownSnackBar.dart';

class NewTrainingScreen extends StatefulWidget {
  @override
  _NewTrainingScreenState createState() => _NewTrainingScreenState();
}

class _NewTrainingScreenState extends State<NewTrainingScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  int setCount = 0;
  String duration = "00:00";

  List<String> images = [];

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
                  items: List<Widget>.from(images
                      .map(
                        (e) => Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(e)),
                            ),
                          ),
                        ),
                      )
                      .toList())
                    ..add(
                      InkWell(
                        onTap: onTapAddImage,
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
                      onTap: onTapDuration,
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              "Dauer",
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
                  ],
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

  onTapSave() {
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
  }

  onTapAddImage() async {
    FocusScope.of(context).unfocus();
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );

    if (result != null) {
      images = result.files.map((e) => e.path).toList();
      setState(() {});
      print("Something should be going on here");
    }
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
