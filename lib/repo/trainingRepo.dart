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
      final temporaryList = <TrainingModel>[];

      temporaryList.addAll(
        List<TrainingModel>.from(
          fireResponse.arguments["trainingList"]
              .map((e) => TrainingModel.fromMap(e))
              .toList(),
        ),
      );

      final orderList = await _sharedProvider.getOrderOfTrainingList();

      print(orderList);

      if (orderList.isNotEmpty) {
        for (int i = 0; i < orderList.length; i++) {
          if (trainingList.indexWhere((e) => e.id == orderList[i]) != -1) {
            trainingList.add(
              temporaryList.firstWhere((element) => element.id == orderList[i]),
            );
          } else {
            orderList.removeAt(i);
            i--;
          }
        }

        _sharedProvider.setOrderOfTrainingList(orderList);
      } else {
        print("We are here");
        trainingList.addAll(temporaryList);
        _sharedProvider.setOrderOfTrainingList(
          List<String>.from(trainingList.map((e) => e.id).toList()),
        );
      }

      return ResponseModel("200", arguments: {
        "trainingList": trainingList,
      });
    } else
      return ResponseModel("404");
  }

  Future<ResponseModel> changeTrainingListOrder(
      List<String> trainingListOrder) async {
    final orderedTrainingList = <TrainingModel>[];

    for (int i = 0; i < trainingListOrder.length; i++) {
      if (trainingList.indexWhere((e) => e.id == trainingListOrder[i]) != -1) {
        orderedTrainingList.add(
          trainingList.firstWhere((e) => e.id == trainingListOrder[i]),
        );
      } else {
        trainingListOrder.removeAt(i);
        i--;
      }
    }

    _sharedProvider.setOrderOfTrainingList(trainingListOrder);

    trainingList.clear();

    trainingList.addAll(orderedTrainingList);

    return ResponseModel(
      "200",
      arguments: {
        "trainingList": trainingList,
      },
    );
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

  editTraining(TrainingModel trainingModel) async {
    final trainingListIndex = trainingList.indexWhere(
      (model) => model.id == trainingModel.id,
    );

    print(trainingListIndex);

    if (trainingListIndex != -1)
      trainingList[trainingListIndex] = trainingModel;

    final trainingPlanIndex =
        trainingPlan.indexWhere((e) => e.id == trainingModel.id);

    if (trainingPlanIndex != -1) {
      trainingPlan[trainingPlanIndex] = trainingModel;
    }

    _fireProvider.editTraining(trainingModel);

    return trainingList;
  }

  deleteTraining(String id) {
    trainingList.removeWhere((element) => element.id == id);
    trainingPlan.removeWhere((element) => element.id == id);
    _fireProvider.deleteTraining(id);
    return trainingList;
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

  deleteUser() async {
    trainingList.clear();
    trainingPlan.clear();
  }
}
