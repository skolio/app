class TrainingModel {
  String id;
  String uid;
  String title;
  String description;
  List<String> imageURLs;
  List<String> imageTitle;
  int sets;
  int repitions;
  Duration pauseBetween;
  bool editable;

  TrainingModel.fromMap(Map data) {
    id = data["id"];
    uid = data["uid"] ?? "";
    title = data["title"];
    description = data["description"];
    imageURLs = List<String>.from(data["imageURLs"]);
    // imageTitle = List<String>.from(data["imageTitle"]);
    sets = data["sets"];
    repitions = data["repitions"];
    pauseBetween = parseDuration(data["pauseBetween"]);
    editable = data["editable"];
  }

  Map<String, dynamic> get asMap => {
        "id": id,
        "uid": uid,
        "title": title,
        "description": description,
        "imageURLs": imageURLs,
        // "imageTitle": imageTitle,
        "sets": sets,
        "repitions": repitions,
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
