import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:skolio/model/responseModel.dart';
import 'package:skolio/model/trainingModel.dart';
import 'package:skolio/repo/trainingRepo.dart';

class TrainingBloc {
  final _trainingRepo = TrainingRepo();

  final _trainingListFetcher = BehaviorSubject();

  ValueStream get trainingList => _trainingListFetcher.stream;

  fetchTrainingList() async {
    final response = await _trainingRepo.fetchTrainingList();

    if (response.code == "200") {
      _trainingListFetcher.sink.add(response.arguments["trainingList"]);
    } else {
      _trainingListFetcher.sink.add([]);
    }
  }

  changeTrainingListOrder(List<String> trainingListOrder) async {
    final response =
        await _trainingRepo.changeTrainingListOrder(trainingListOrder);

    _trainingListFetcher.sink.add(response.arguments["trainingList"]);
  }

  Future<ResponseModel> addOwnTraining(TrainingModel trainingModel) async {
    final result = await _trainingRepo.addOwnTraining(trainingModel);
    if (result.code == "200") {
      _trainingListFetcher.sink.add(result.arguments["trainingList"]);
      return ResponseModel("200");
    } else
      return result;
  }

  Future<ResponseModel> editTraining(TrainingModel trainingModel) async {
    final response = await _trainingRepo.editTraining(trainingModel);

    _trainingListFetcher.sink.add(response);

    return ResponseModel("200");
  }

  deleteTraining(String id) {
    _trainingListFetcher.sink.add(_trainingRepo.deleteTraining(id));
  }

  TrainingModel fetchTrainingModel(String id) =>
      _trainingRepo.fetchTrainingModel(id);

  deleteUser() {
    _trainingRepo.deleteUser();
  }

  dispose() {
    _trainingListFetcher.close();
  }
}

final trainingBloc = TrainingBloc();
