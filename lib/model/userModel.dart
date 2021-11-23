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

  setOrderOfTrainingPlan(List<String> trainingPlanOrder) {
    final List<String> orderedPlan = <String>[];

    if (trainingPlanOrder == null || trainingPlanOrder.isEmpty) {
      return;
    }

    trainingPlanOrder.forEach((e) {
      if (trainingPlan.contains(e)) {
        orderedPlan.add(e);
      }
    });

    orderedPlan.addAll(
      trainingPlan.where((e) => !orderedPlan.contains(e)).toList(),
    );

    trainingPlan.clear();
    trainingPlan.addAll(orderedPlan);
  }
}
