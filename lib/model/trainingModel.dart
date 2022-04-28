import 'package:skolio/model/trainingModelInterface.dart';

class TrainingModel implements TrainingModelInterface {
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

  String description;
  List<String> imageTitle;
  int sets;
  Duration pauseBetween;
  bool editable;

  TrainingModel.fromMap(Map data) {
    id = data["id"];
    uid = data["uid"] ?? "";
    title = data["title"];
    iconURL = data["iconURL"] ?? "";
    imageURLs = List<String>.from(data["imageURLs"]);
    repititions = data["repitions"];

    description = data["description"];
    // imageTitle = List<String>.from(data["imageTitle"]);
    sets = data["sets"];
    pauseBetween = parseDuration(data["pauseBetween"]);
    editable = data["editable"];
  }

  Map<String, dynamic> get asMap => {
        "id": id,
        "uid": uid,
        "title": title,
        "iconURL": iconURL,
        "imageURLs": imageURLs,
        "repitions": repititions,
        "description": description,
        // "imageTitle": imageTitle,
        "sets": sets,
        "pauseBetween": pauseBetween.toString(),
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
