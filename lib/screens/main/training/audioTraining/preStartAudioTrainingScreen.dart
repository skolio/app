import 'package:flutter/material.dart';
import 'package:skolio/model/trainingAudioModel.dart';
import 'package:skolio/provider/audioProvider.dart';

class PreStartAudioTrainingScreen extends StatefulWidget {
  final TrainingAudioModel trainingAudioModel;

  PreStartAudioTrainingScreen(this.trainingAudioModel);

  @override
  State<PreStartAudioTrainingScreen> createState() =>
      _PreStartAudioTrainingScreenState();
}

class _PreStartAudioTrainingScreenState
    extends State<PreStartAudioTrainingScreen> {
  AudioProvider audioProvider = AudioProvider();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Übungsausführung",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(),
          ],
        ),
      ),
    );
  }
}
