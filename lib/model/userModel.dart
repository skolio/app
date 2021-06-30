import 'package:skolio/screens/main/statsScreen.dart';

class UserModel {
  String uid;
  String username;
  String email;
  List<String> trainingPlan;
  Map statistic;

  UserModel.fromMap(Map data, Map statistic) {
    uid = data["uid"];
    username = data["username"];
    email = data["email"];
    trainingPlan = List<String>.from(data["trainingPlan"]);
    this.statistic = statistic;
  }

  Map<String, dynamic> get asMap => {
        "uid": uid,
        "username": username,
        "email": email,
        "trainingPlan": trainingPlan,
      };
}
