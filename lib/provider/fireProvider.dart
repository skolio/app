import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:skolio/model/responseModel.dart';
import 'package:skolio/model/trainingModel.dart';
import 'package:skolio/model/userModel.dart';
import '../model/responseModel.dart';
import 'package:uuid/uuid.dart';

class FireProvider {
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  //* AuthenticationMethods

  Future<ResponseModel> initUser() async {
    if (_auth.currentUser == null) {
    } else {
      final userDoc =
          await _store.collection("Users").doc(_auth.currentUser.uid).get();

      if (userDoc.data() == null) {
        _auth.currentUser.delete();
        _auth.signOut();
        return ResponseModel("400");
      }

      final statDocs = await _store
          .collection("Users")
          .doc(_auth.currentUser.uid)
          .collection("Statistics")
          .get();

      print(statDocs.size);

      Map statList = {};

      print("This is stopping here");
      statDocs.docs.forEach((element) {
        print(element.data()["record"]);
        statList[element.id] = element.data()["record"];
      });

      print("This is the statLists length");

      print(statList.keys.length);

      return ResponseModel(
        "200",
        arguments: {
          "userModel": UserModel.fromMap(userDoc.data(), statList),
        },
      );
    }

    return ResponseModel("400");
  }

  Future<ResponseModel> loginUser(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (result.user == null) {
        return ResponseModel("404", arguments: {
          "message":
              "Ein interner Fehler ist aufgetreten bitte kontaktieren sie den Entwickler"
        });
      }

      if (!result.user.emailVerified) {
        return ResponseModel(
          "404",
          arguments: {
            "message": "Bitte verifizieren Sie Ihre E-Mail Adresse",
          },
        );
      }

      final userDoc =
          await _store.collection("Users").doc(result.user.uid).get();

      if (userDoc.data() == null) {
        result.user.delete();
        return ResponseModel("404", arguments: {
          "message":
              "Es konnte kein User mit dieser E-Mail Adresse gefunden werden"
        });
      }

      final statDocs = await _store
          .collection("Users")
          .doc(result.user.uid)
          .collection("Statistics")
          .get();

      Map<String, List<String>> statList = {};

      statDocs.docs.forEach((element) {
        statList.putIfAbsent(element.id, () => element.data()["record"]);
      });

      return ResponseModel(
        "200",
        arguments: {
          "userModel": UserModel.fromMap(userDoc.data(), statList),
        },
      );
    } catch (e) {
      if (e is FirebaseException)
        return ResponseModel(e.code, arguments: {
          "message": getFirebaseErrorMessage(e.code),
        });
      else
        return ResponseModel("404", arguments: {
          "message": getFirebaseErrorMessage(e.code),
        });
    }
  }

  Future<ResponseModel> registerUser(
      UserModel userModel, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: userModel.email, password: password);

      await result.user.sendEmailVerification();

      if (result.user == null) {
        return ResponseModel(
          "404",
          arguments: {
            "message":
                "Ein interner Fehler ist aufgetreten bitte kontaktieren sie den Entwickler"
          },
        );
      }

      userModel.uid = result.user.uid;

      await _store.collection("Users").doc(userModel.uid).set(userModel.asMap);

      return ResponseModel("200");
    } catch (e) {
      if (e is FirebaseException)
        return ResponseModel(e.code, arguments: {
          "message": getFirebaseErrorMessage(e.code),
        });
      else
        return ResponseModel("404", arguments: {
          "message": getFirebaseErrorMessage(e.code),
        });
    }
  }

  Future<ResponseModel> changeEmail(
      String email, String newEmail, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (result.user == null) {
        return ResponseModel("404", arguments: {
          "message":
              "Es ist ein Fehler aufgetreten bitte versuchen Sie es später erneut",
        });
      }

      await result.user.updateEmail(newEmail);

      return ResponseModel("200");
    } catch (e) {
      if (e is FirebaseException)
        return ResponseModel(e.code, arguments: {
          "message": getFirebaseErrorMessage(e.code),
        });
      else
        return ResponseModel("404", arguments: {
          "message": getFirebaseErrorMessage(e.code),
        });
    }
  }

  Future<ResponseModel> changePassword(
      String email, String password, String newPassword) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (result.user == null) {
        return ResponseModel("404", arguments: {
          "message":
              "Es ist ein Fehler aufgetreten bitte versuchen Sie es später erneut",
        });
      }

      await result.user.updatePassword(newPassword);

      return ResponseModel("200");
    } catch (e) {
      if (e is FirebaseException)
        return ResponseModel(e.code, arguments: {
          "message": getFirebaseErrorMessage(e.code),
        });
      else
        return ResponseModel("404", arguments: {
          "message": getFirebaseErrorMessage(e.code),
        });
    }
  }

  String getFirebaseErrorMessage(String code) {
    switch (code) {
      case "invalid-email":
        return "Bitte geben Sie eine valide E-Mail Adresse ein";
      case "wrong-password":
        return "Das von Ihnen eingegeben Passwort ist nicht korrekt";
      case "user-not-found":
        return "Ein User mit dieser E-Mail Adresse konnte nicht gefunden werden";
      case "user-disabled":
        return "Der User mit dieser E-Mail wurde gesperrt. Bitte kontaktieren Sie den Kundendienst";
      case "too-many-request":
        return "Zu biele Anfragen, bitte versuchen Sie es später erneut";
      case "operation-not-allowed":
        return "Bitte Kontaktieren sie den Eigentümer der App, weil das einloggen gesperrt wurde";
      case "email-already-in-use":
        return "Diese E-Mail wurde schon registriert. Bitte melden Sie sich an oder setzen Sie ihr Passwort zurück.";
      default:
        return "Ein interner Fehler ist aufgetreten. Bitte kontaktieren sie den Entwickler der App";
    }
  }

  signOut() {
    _auth.signOut();
  }

  deleteUser() async {
    final ownTrainingDocs = await _store
        .collection("OwnTraining")
        .where("uid", isEqualTo: _auth.currentUser.uid)
        .get();

    if (ownTrainingDocs.size != 0) {
      ownTrainingDocs.docs.forEach((element) {
        Map data = element.data();
        data["imageURLs"].forEach((e) {
          _storage.refFromURL(e).delete();
        });
        _store.collection("OwnTraining").doc(element.id).delete();
      });
    }

    _store.collection("Users").doc(_auth.currentUser.uid).delete();

    _auth.currentUser.delete();
  }

  //* TrainingMethods

  Future<ResponseModel> fetchTrainingList() async {
    final trainingListResult = await _store.collection("Training").get();
    final ownTrainingListResult = await _store
        .collection("OwnTraining")
        .where("uid", isEqualTo: _auth.currentUser.uid)
        .get();

    List<Map> returnList = [];

    if (trainingListResult.size != 0)
      returnList.addAll(trainingListResult.docs.map((e) => e.data()).toList());

    if (ownTrainingListResult.size != 0) {
      returnList
          .addAll(ownTrainingListResult.docs.map((e) => e.data()).toList());
      ownTrainingListResult.docs.forEach((element) {
        print(element.data());
      });
    }

    if (returnList.length == 0) {
      return ResponseModel("404");
    } else
      return ResponseModel("200", arguments: {
        "trainingList": returnList,
      });
  }

  Future<ResponseModel> addOwnTraining(TrainingModel ownTrainingModel) async {
    List<String> imageURLs = [];

    for (int i = 0; i < ownTrainingModel.imageURLs.length; i++) {
      imageURLs.add(await uploadFile(ownTrainingModel.imageURLs[i]));
    }

    final trainingDoc = _store.collection("OwnTraining").doc();
    ownTrainingModel.imageURLs = imageURLs;
    ownTrainingModel.id = trainingDoc.id;

    await trainingDoc.set(ownTrainingModel.asMap);
    await trainingDoc.update({"uid": _auth.currentUser.uid});

    return ResponseModel("200");
  }

  editTraining(TrainingModel trainingModel) async {
    for (int i = 0; i < trainingModel.imageURLs.length; i++) {
      if (!trainingModel.imageURLs[i].contains("https://")) {
        final response = await uploadFile(trainingModel.imageURLs[i]);
        trainingModel.imageURLs[i] = response;
      }
    }
    print(trainingModel.asMap);
    _store
        .collection("OwnTraining")
        .doc(trainingModel.id)
        .update(trainingModel.asMap);
  }

  deleteTraining(String id) {
    _store.collection("Training").doc(id).delete();
  }

  addTrainingToPlan(String trainingID) {
    _store.collection("Users").doc(_auth.currentUser.uid).update(
      {
        "trainingPlan": FieldValue.arrayUnion([trainingID]),
      },
    );
  }

  removeTrainingFromPlan(String trainingID) {
    _store.collection("Users").doc(_auth.currentUser.uid).update({
      "trainingPlan": FieldValue.arrayRemove([trainingID]),
    });
  }

  addTrainingToStats(String id) async {
    final statsDoc = await _store
        .collection("Users")
        .doc(_auth.currentUser.uid)
        .collection("Statistics")
        .doc(DateTime.now().toString().split(" ").first)
        .get();

    if (statsDoc.data() == null) {
      await _store
          .collection("Users")
          .doc(_auth.currentUser.uid)
          .collection("Statistics")
          .doc(DateTime.now().toString().split(" ").first)
          .set({
        "record": FieldValue.arrayUnion([id])
      });
    } else {
      await _store
          .collection("Users")
          .doc(_auth.currentUser.uid)
          .collection("Statistics")
          .doc(DateTime.now().toString().split(" ").first)
          .update({
        "record": FieldValue.arrayUnion([id])
      });
    }
  }

  //* StorageMethods
  Future<String> uploadFile(String filePath) async {
    final uuid = Uuid();

    final storageName = DateTime.now().toString() + "." + uuid.v4();

    final ref = _storage.ref().child(storageName);
    final uploadTask = ref.putFile(File(filePath));
    await uploadTask;

    final url = await (await uploadTask).ref.getDownloadURL();

    return url;
  }
}
