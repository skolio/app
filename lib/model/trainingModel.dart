import 'package:flutter/foundation.dart';

class TrainingModel {
  String title;
  String description;
  List<String> imageURLs;
  List<String> imageTitle;
  int sets;
  Duration timeDuration;

  TrainingModel(Map data) {
    title = data["title"];
    description = data["description"];
    imageURLs = List<String>.from(data["imageURLs"]);
    imageTitle = List<String>.from(data["imageTitle"]);
    sets = data["sets"];
    timeDuration = parseDuration(data["duration"]);
  }

  Map<String, dynamic> get asMap => {
        "title": title,
        "description": description,
        "imageURLs": imageURLs,
        "imageTitle": imageTitle,
        "sets": sets,
        "duration": timeDuration.toString(),
      };

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
