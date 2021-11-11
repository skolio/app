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

  Future<ResponseModel> addOwnTraining(TrainingModel trainingModel) async {
    final sharedPref = await SharedPreferences.getInstance();

    final result = sharedPref.getStringList("TrainingList");

    if (result == null) {
      await sharedPref.setStringList("TrainingList", [
        jsonEncode(trainingModel.asMap),
      ]);

      return ResponseModel("200");
    } else {
      List<Map> trainingModels = result.map((e) => jsonDecode(e)).toList();

      trainingModels.add(trainingModel.asMap);

      await sharedPref.setStringList(
        "TrainingList",
        trainingModels.map((e) => jsonEncode(e)).toList(),
      );

      return ResponseModel("200");
    }
  }
}
