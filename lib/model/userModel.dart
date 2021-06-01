class UserModel {
  String uid;
  String username;
  String email;
  List<String> trainingPlan;

  UserModel.fromMap(Map data) {
    uid = data["uid"];
    username = data["username"];
    email = data["email"];
    trainingPlan = List<String>.from(data["trainingPlan"]);
  }

  Map<String, dynamic> get asMap => {
        "uid": uid,
        "username": username,
        "email": email,
        "trainingPlan": trainingPlan,
      };
}
