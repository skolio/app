import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class NavigatorBloc {
  final _indexFetcher = BehaviorSubject();

  ValueStream get indexStream => _indexFetcher.stream;

  changeIndex(newIndex) {
    _indexFetcher.sink.add(newIndex);
  }

  dispose() {
    _indexFetcher.close();
  }
}

final navigatorBloc = NavigatorBloc();
