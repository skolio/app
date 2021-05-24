import 'package:rxdart/rxdart.dart';
import 'package:skolio/model/responseModel.dart';
import 'package:skolio/model/userModel.dart';
import 'package:skolio/provider/fireProvider.dart';

class AuthenticationBloc {
  final _fireProvider = FireProvider();
  final _userFetcher = BehaviorSubject();

  ValueStream get currentUser => _userFetcher.stream;

  initUser() async {}

  Future<ResponseModel> loginUser(String email, String password) async {
    final response = _fireProvider.loginUser(email, password);
  }

  Future<ResponseModel> registerUser(
      UserModel userModel, String password) async {}

  dispose() {
    _userFetcher.close();
  }
}

final authenticationBloc = AuthenticationBloc();
