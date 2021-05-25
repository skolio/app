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

    //Check if 200 and add it to the list

    final sharedResponse = await _sharedProvider.fetchTrainingList();

    //Check if 200 and add it to the list
  }

  TrainingModel fetchTrainingModel(String id) {
    //Just return one TrainingModel, the plan will be saved within the UserModel
  }

  Future<ResponseModel> addOwnTraining(TrainingModel trainingModel) async {
    final response = await _sharedProvider.addOwnTraining(trainingModel);

    if (response.code == "200") {
      trainingList.add(trainingModel);
      return ResponseModel("200");
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
