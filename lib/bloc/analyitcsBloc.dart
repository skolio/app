import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsBloc {
  final _instance = FirebaseAnalytics();

  logAppStart() {
    _instance.logEvent(name: "open_app");
  }

  logRegisterFinished() {
    _instance.logEvent(name: "register_complete");
  }

  logNewTraining() {
    _instance.logEvent(name: "training_created");
  }

  logTrainingDelete() {
    _instance.logEvent(name: "training_delete");
  }

  logTrainingStart() {
    _instance.logEvent(name: "training_start");
  }

  logTrainingFinished() {
    _instance.logEvent(name: "training_finished");
  }

  logImageUpload() {
    _instance.logEvent(name: "image_upload");
  }
}

final analyticsBloc = AnalyticsBloc();
