import 'package:rxdart/rxdart.dart';
import 'package:skolio/model/responseModel.dart';
import 'package:skolio/model/userModel.dart';
import 'package:skolio/provider/fireProvider.dart';

import '../model/responseModel.dart';

class AuthenticationBloc {
  final _fireProvider = FireProvider();
  final _userFetcher = BehaviorSubject();

  ValueStream get currentUser => _userFetcher.stream;

  initUser() async {
    final response = await _fireProvider.initUser();

    if (response.code == "200") {
      _userFetcher.sink.add(response.arguments["userModel"]);
    } else {
      _userFetcher.sink.add(null);
    }
  }

  Future<ResponseModel> loginUser(String email, String password) async {
    final response = await _fireProvider.loginUser(email, password);

    if (response.code == "200") {
      _userFetcher.sink.add(response.arguments["userModel"]);
      return ResponseModel("200");
    } else
      return response;
  }

  Future<ResponseModel> registerUser(
      UserModel userModel, String password) async {
    final response = await _fireProvider.registerUser(userModel, password);

    if (response.code == "200") {
      _userFetcher.sink.add(response.arguments["userModel"]);
      return ResponseModel("200");
    } else
      return response;
  }

  Future<ResponseModel> changeEmail(
      String email, String newEmail, String password) async {
    final response = await _fireProvider.changeEmail(email, newEmail, password);

    if (response.code == "200") {
      UserModel userModel = _userFetcher.value;
      userModel.email = newEmail;
      _userFetcher.sink.add(userModel);
      return ResponseModel("200");
    } else
      return response;
  }

  Future<ResponseModel> changePassword(
          String email, String password, String newPassword) async =>
      _fireProvider.changePassword(email, password, newPassword);

  signOutUser() {
    _userFetcher.sink.add(null);
    _fireProvider.signOut();
  }

  addTrainingToPlan(String trainingID) {
    UserModel userModel = _userFetcher.value;
    userModel.trainingPlan.add(trainingID);
    _userFetcher.sink.add(userModel);
    _fireProvider.addTrainingToPlan(trainingID);
  }

  removeTrainingFromPlan(String trainingID) {
    UserModel userModel = _userFetcher.value;
    userModel.trainingPlan.remove(trainingID);
    _userFetcher.sink.add(userModel);
    _fireProvider.removeTrainingFromPlan(trainingID);
  }

  addTrainingToStats(String id) async {
    UserModel userModel = _userFetcher.value;
    if (userModel.statistic[DateTime.now().toString().split(" ").first] !=
        null) {
      print("We are here but it doesnt want to work now");
      userModel.statistic[DateTime.now().toString().split(" ").first].add(id);
    } else {
      userModel.statistic[DateTime.now().toString().split(" ")] = [id];
    }
    print("Here are some other things going on");
    await _fireProvider.addTrainingToStats(id);
    initUser();
    _userFetcher.sink.add(userModel);
  }

  dispose() {
    _userFetcher.close();
  }
}

final authenticationBloc = AuthenticationBloc();
