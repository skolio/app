import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skolio/model/responseModel.dart';
import 'package:skolio/model/userModel.dart';
import '../model/responseModel.dart';

class FireProvider {
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;

  //* AuthenticationMethods

  Future<ResponseModel> initUser() async {
    if (_auth.currentUser == null) {
      print("Noone is logge in currently");
    } else {
      final userDoc =
          await _store.collection("Users").doc(_auth.currentUser.uid).get();

      if (userDoc.data() == null) {
        _auth.currentUser.delete();
        _auth.signOut();
        return ResponseModel("400");
      }

      return ResponseModel(
        "200",
        arguments: {
          "userModel": UserModel.fromMap(userDoc.data()),
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

      final userDoc =
          await _store.collection("Users").doc(result.user.uid).get();

      if (userDoc.data() == null) {
        result.user.delete();
        return ResponseModel("404", arguments: {
          "message":
              "Es konnte kein User mit dieser E-Mail Adresse gefunden werden"
        });
      }

      return ResponseModel(
        "200",
        arguments: {
          "userModel": UserModel.fromMap(userDoc.data()),
        },
      );
    } catch (e) {
      if (e is FirebaseException) {
        return ResponseModel(
          e.code,
          arguments: {
            "message": e.message,
          },
        );
      } else
        return ResponseModel("404");
    }
  }

  Future<ResponseModel> registerUser(
      UserModel userModel, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: userModel.email, password: password);

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

      _store.collection("Users").doc(userModel.uid).set(userModel.asMap);

      return ResponseModel("200", arguments: {"userModel": userModel});
    } catch (e) {
      if (e is FirebaseException) {
        return ResponseModel(
          e.code,
          arguments: {
            "message": e.message,
          },
        );
      } else
        return ResponseModel("404");
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
}
