import 'package:flutter/material.dart';
import 'package:skolio/model/trainingModelInterface.dart';

class TrainingAudioModel implements TrainingModelInterface {
  @override
  String id;
  @override
  String uid;
  @override
  String title;
  @override
  String iconURL;
  @override
  List<String> imageURLs;
  @override
  int repititions;
  @override
  bool editable;

  String goalOfExercise;
  String startingPosition;
  String executionDescription;
  String tools;
  String cave;

  String executionAudio;
  String mantraAudio;
  String startingPositionAudio;

  TrainingAudioModel.fromMap(Map data) {
    id = data["id"];
    uid = data["uid"];
    title = data["title"];
    iconURL = data["iconURL"] ?? "";
    imageURLs = List<String>.from(data["imageURLs"]);
    repititions = data["repititions"];
    editable = !data["editable"];

    goalOfExercise = data["goalOfExercises"];
    goalOfExercise = goalOfExercise.replaceAll("\n", "");
    goalOfExercise = goalOfExercise.replaceAll("-", "\n-");
    startingPosition = data["startingPosition"];
    startingPosition = startingPosition.replaceAll("\n", "");
    startingPosition = startingPosition.replaceAll("-", "\n-");
    executionDescription = data["executionDescription"];
    executionDescription = executionDescription.replaceAll("\n", "");
    executionDescription = executionDescription.replaceAll("-", "\n-");

    tools = data["tools"];
    tools = tools.replaceAll("\n", "");
    tools = tools.replaceAll("-", "\n-");
    cave = data["cave"];
    cave = cave.replaceAll("\n", "");
    cave = cave.replaceAll("-", "\n-");

    executionAudio = data["executionAudio"];
    startingPositionAudio = data["startingPositionAudio"];
    mantraAudio = data["mantraAudio"];
  }

  Map<String, dynamic> get asMap => {
        "id": id,
        "uid": uid,
        "title": title,
        "goalOfExercises": goalOfExercise,
        "startingPosition": startingPosition,
        "repititions": repititions,
        "executionDescription": executionDescription,
        "tools": tools,
        "cave": cave,
        "imageURLs": imageURLs,
        "iconURL": iconURL,
      };
}
