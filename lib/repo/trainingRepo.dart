import 'package:skolio/model/responseModel.dart';
import 'package:skolio/model/trainingAudioModel.dart';
import 'package:skolio/model/trainingModel.dart';
import 'package:skolio/model/trainingModelInterface.dart';
import 'package:skolio/provider/fireProvider.dart';
import 'package:skolio/provider/sharedProvider.dart';

class TrainingRepo {
  final _fireProvider = FireProvider();
  final _sharedProvider = SharedProvider();

  List<TrainingModelInterface> trainingList = [];
  List<TrainingModelInterface> trainingPlan = [];

  Future<ResponseModel> fetchTrainingList() async {
    final fireResponse = await _fireProvider.fetchTrainingList();

    trainingList.clear();

    if (fireResponse.code == "200") {
      final temporaryList = <TrainingModelInterface>[];

      temporaryList.addAll(
        List<TrainingModelInterface>.from(
          fireResponse.arguments["trainingList"].map((e) {
            if ((e as Map).containsKey("description"))
              return TrainingModel.fromMap(e);
            else
              return TrainingAudioModel.fromMap(e);
          }).toList(),
        ),
      );

      if (temporaryList.isEmpty) {
        await _sharedProvider.setOrderOfTrainingList([]);
        return ResponseModel("200", arguments: {
          "trainingList": [],
        });
      }

      final orderList = await _sharedProvider.getOrderOfTrainingList();
      if (orderList != null && orderList.isNotEmpty)
        orderList.removeWhere((element) =>
            temporaryList.indexWhere((e) => e.id == element) == -1);

      if (orderList != null && orderList.isNotEmpty) {
        for (int i = 0; i < orderList.length; i++) {
          if (trainingList.isEmpty)
            trainingList.add(
              temporaryList.firstWhere((element) => element.id == orderList[i],
                  orElse: () => null),
            );
          else if (trainingList.indexWhere((e) => e.id == orderList[i]) == -1) {
            trainingList.add(
              temporaryList.firstWhere((element) => element.id == orderList[i],
                  orElse: () => null),
            );
          } else {
            orderList.removeAt(i);
            i--;
          }
        }

        trainingList.addAll(
          temporaryList.where(
            (element) => !orderList.contains(element.id),
          ),
        );

        _sharedProvider.setOrderOfTrainingList(
          List<String>.from(trainingList.map((e) => e.id).toList()),
        );
      } else {
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
    final orderedTrainingList = <TrainingModelInterface>[];

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

  TrainingModelInterface fetchTrainingModel(String id) =>
      trainingList.firstWhere((element) => element.id == id);

  Future<ResponseModel> addOwnTraining(
      TrainingModelInterface trainingModel, bool uploadToCloud) async {
    final response =
        await _fireProvider.addOwnTraining(trainingModel, uploadToCloud);

    if (response.code == "200") {
      trainingList.add(trainingModel);
      return ResponseModel("200", arguments: {
        "trainingList": trainingList,
      });
    }
    return response;
  }

  editTraining(TrainingModelInterface trainingModel, bool uploadToCloud) async {
    final trainingListIndex = trainingList.indexWhere(
      (model) => model.id == trainingModel.id,
    );

    if (trainingListIndex != -1)
      trainingList[trainingListIndex] = trainingModel;

    final trainingPlanIndex =
        trainingPlan.indexWhere((e) => e.id == trainingModel.id);

    if (trainingPlanIndex != -1) {
      trainingPlan[trainingPlanIndex] = trainingModel;
    }

    _fireProvider.editTraining(trainingModel, uploadToCloud);

    return trainingList;
  }

  deleteTraining(String id) {
    trainingList.removeWhere((element) => element.id == id);
    trainingPlan.removeWhere((element) => element.id == id);
    _fireProvider.deleteTraining(id);
    return trainingList;
  }

  List<TrainingModelInterface> addTrainingToPlan(String trainingID) {
    trainingPlan
        .add(trainingList.firstWhere((element) => element.id == trainingID));

    return trainingPlan;
  }

  List<TrainingModelInterface> removeTrainingFromPlan(String trainingID) {
    trainingPlan.removeWhere((element) => element.id == trainingID);

    return trainingPlan;
  }

  deleteUser() async {
    trainingList.clear();
    trainingPlan.clear();
  }
}
