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

  Future<ResponseModel> addOwnTraining() async {}
}
