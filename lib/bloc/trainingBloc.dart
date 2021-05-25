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
    _trainingListFetcher.sink.add([]);
  }

  Future<ResponseModel> addOwnTraining(TrainingModel trainingModel) async {
    final result = await _trainingRepo.addOwnTraining(trainingModel);
    if (result.code == "200") {
      _trainingListFetcher.sink.add(result.arguments["trainingList"]);
    }
  }

  dispose() {
    _trainingListFetcher.close();
  }
}

final trainingBloc = TrainingBloc();
