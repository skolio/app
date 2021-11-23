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

      return response;
    } catch (e, stackTrace) {
      print("There was an error");
      print(stackTrace);
      return [];
    }
  }

  setOrderOfTrainingList(List<String> trainingListIDs) async {
    await init();

    _instance.setStringList("TrainingListOrder", trainingListIDs);
  }

  Future<List<String>> getOrderOfTrainingPlan() async {
    await init();

    try {
      final response = _instance.getStringList("TrainingPlanOrder");

      return response;
    } catch (e, stackTrace) {
      print(
          "There was some error in the getOrderOfTrainingPlan method $stackTrace");

      return [];
    }
  }

  setOrderOfTrainingPlan(List<String> trainingPlanOrder) async {
    await init();

    _instance.setStringList("TrainingPlanOrder", trainingPlanOrder);
  }
}
