import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:skolio/model/responseModel.dart';
import 'package:skolio/model/trainingModel.dart';

class SharedProvider {
  Future<ResponseModel> fetchTrainingList() async {
    final sharedPref = await SharedPreferences.getInstance();

    final result = sharedPref.getStringList("TrainingList");

    if (result == null) {
      return ResponseModel("400");
    } else {
      return ResponseModel("200", arguments: {
        "trainingList": result.map((e) => jsonDecode(e)).toList(),
      });
    }
  }

  Future<ResponseModel> addOwnTraining(TrainingModel trainingModel) async {}

  fetchHistory() {}
}
