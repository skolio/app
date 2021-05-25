import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class TrainingBloc {
  final _trainingListFetcher = BehaviorSubject();

  ValueStream get trainingList => _trainingListFetcher.stream;

  fetchTrainingList() async {
    _trainingListFetcher.sink.add([]);
  }

  addOwnTraining() {}

  dispose() {
    _trainingListFetcher.close();
  }
}

final trainingBloc = TrainingBloc();
