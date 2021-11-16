import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:skolio/model/responseModel.dart';
import 'package:skolio/model/trainingModel.dart';

class SharedProvider {
  SharedPreferences _instance;

  init() async {
    if (_instance == null) _instance = await SharedPreferences.getInstance();
  }

  Future<ResponseModel> fetchTrainingList() async {
    await init();

    final result = _instance.getStringList("TrainingList");

    if (result == null) {
      return ResponseModel("400");
    } else {
      return ResponseModel("200", arguments: {
        "trainingList": result.map((e) => jsonDecode(e)).toList(),
      });
    }
  }

  Future<ResponseModel> addOwnTraining(TrainingModel trainingModel) async {
    await init();

    final result = _instance.getStringList("TrainingList");

    if (result == null) {
      await _instance.setStringList("TrainingList", [
        jsonEncode(trainingModel.asMap),
      ]);

      return ResponseModel("200");
    } else {
      List<Map> trainingModels = result.map((e) => jsonDecode(e)).toList();

      trainingModels.add(trainingModel.asMap);

      await _instance.setStringList(
        "TrainingList",
        trainingModels.map((e) => jsonEncode(e)).toList(),
      );

      return ResponseModel("200");
    }
  }

  Future<List<String>> getOrderOfTrainingList() async {
    await init();
    try {
      final response = _instance.getStringList("TrainingListOrder");

      if (response.isEmpty) return [];

      return response;
    } catch (e) {
      return [];
    }
  }

  setOrderOfTrainingList(List<String> trainingListIDs) async {
    await init();

    print("Setting some order for the list");

    _instance.setStringList("TrainingListOrder", trainingListIDs);
  }
}
