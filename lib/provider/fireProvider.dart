import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skolio/model/responseModel.dart';
import 'package:skolio/model/userModel.dart';

class FireProvider {
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;

  Future<ResponseModel> initUser() async {
    return ResponseModel("400");
  }

  Future<ResponseModel> loginUser(String email, String password) async {
    return ResponseModel("400");
  }

  Future<ResponseModel> registerUser(
      UserModel userModel, String password) async {
    return ResponseModel("400");
  }
}
