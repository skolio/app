class UserModel {
  String uid;
  String username;
  String email;
  List<String> trainingsPlan;

  UserModel.fromMap(Map data) {
    uid = data["uid"];
    username = data["username"];
    email = data["email"];
    trainingsPlan = data["trainingsPlan"];
  }

  Map<String, dynamic> get asMap => {
        "uid": uid,
        "username": username,
        "email": email,
        "trainingsPlan": trainingsPlan,
      };
}
