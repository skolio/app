import 'package:skolio/model/responseModel.dart';
import 'package:skolio/model/trainingModel.dart';
import 'package:skolio/provider/fireProvider.dart';
import 'package:skolio/provider/sharedProvider.dart';

class TrainingRepo {
  final _fireProvider = FireProvider();
  final _sharedProvider = SharedProvider();

  List<TrainingModel> trainingList = [];
  List<TrainingModel> trainingPlan = [];

  Future<ResponseModel> fetchTrainingList() async {
    final fireResponse = await _fireProvider.fetchTrainingList();

    if (fireResponse.code == "200") {
      trainingList.addAll(
        List<TrainingModel>.from(
          fireResponse.arguments["trainingList"]
              .map((e) => TrainingModel.fromMap(e))
              .toList(),
        ),
      );

      return ResponseModel("200", arguments: {
        "trainingList": trainingList,
      });
    } else
      return ResponseModel("404");
  }

  TrainingModel fetchTrainingModel(String id) =>
      trainingList.firstWhere((element) => element.id == id);

  Future<ResponseModel> addOwnTraining(TrainingModel trainingModel) async {
    final response = await _fireProvider.addOwnTraining(trainingModel);

    if (response.code == "200") {
      trainingList.add(trainingModel);
      return ResponseModel("200", arguments: {
        "trainingList": trainingList,
      });
    }
    return response;
  }

  List<TrainingModel> addTrainingToPlan(String trainingID) {
    trainingPlan
        .add(trainingList.firstWhere((element) => element.id == trainingID));

    return trainingPlan;
  }

  List<TrainingModel> removeTrainingFromPlan(String trainingID) {
    trainingPlan.removeWhere((element) => element.id == trainingID);

    return trainingPlan;
  }
}
