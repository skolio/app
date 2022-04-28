import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skolio/bloc/authenticationBloc.dart';
import 'package:skolio/bloc/trainingBloc.dart';
import 'package:skolio/model/trainingAudioModel.dart';
import 'package:skolio/model/trainingModel.dart';
import 'package:skolio/model/trainingModelInterface.dart';
import 'package:skolio/provider/audioProvider.dart';
import 'package:skolio/screens/main/training/finishedTrainingScreen.dart';
import 'package:skolio/screens/main/training/trainingScreen.dart';
import 'package:skolio/widgets/general/halfCircleWidget.dart';

class PreTrainingScreen extends StatefulWidget {
  @override
  _PreTrainingScreenState createState() => _PreTrainingScreenState();
}

class _PreTrainingScreenState extends State<PreTrainingScreen> {
  AudioProvider _audioProvider = AudioProvider();
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    _disposed = true;
    _audioProvider.stopPlayingAudio();
  }

  _handler(Duration delay) async {
    await Future.delayed(delay);
    if (_disposed) return;
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrainingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: authenticationBloc.currentUser.valueOrNull,
        stream: authenticationBloc.currentUser,
        builder: (context, snapshot) {
          if (snapshot.data == null)
            return Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(Theme.of(context).primaryColor),
              ),
            );

          List<String> trainingPlan = [];

          if (snapshot
                  .data.statistic[DateTime.now().toString().split(" ").first] !=
              null)
            snapshot.data.trainingPlan.forEach((element) {
              if (!snapshot
                  .data.statistic[DateTime.now().toString().split(" ").first]
                  .contains(element)) trainingPlan.add(element);
            });
          else {
            trainingPlan = snapshot.data.trainingPlan;
          }

          if (trainingPlan.length == 0) return Container();

          TrainingModelInterface trainingModel =
              trainingBloc.fetchTrainingModel(trainingPlan.first);

          if (trainingModel is TrainingAudioModel) {
            _audioProvider
                .setURL(trainingModel.startingPositionAudio)
                .then((otherValue) async {
              // await Future.delayed(Duration(seconds: 1));
              // _audioProvider.getDuration().then((value) {
              //   _handler(Duration(milliseconds: value));
              //   _audioProvider.togglePlayer();
              // });
            });
          } else
            _handler(Duration(seconds: 2));

          //TODO here we just need to set the startingPositionAudio and then just start the counter again

          return GestureDetector(
            onTap: () {
              _disposed = true;
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrainingScreen(),
                ),
              );
            },
            child: Scaffold(
              appBar: AppBar(
                leading: Container(),
              ),
              body: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.25 - 30,
                    ),
                    child: HalfCircle(),
                  ),
                  Container(
                    color: Theme.of(context).primaryColor,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.25,
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(bottom: 5, left: 30),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 50,
                          spreadRadius: 0,
                          offset: Offset(0, 4),
                          color: Color.fromRGBO(0, 0, 0, 0.03),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: MediaQuery.of(context).size.height * 0.25 - 100,
                    ),
                    height: 280,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "Mach dich bereit!",
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          trainingModel is TrainingAudioModel
                              ? "Ausgangsstellung einnehmen"
                              : "Deine Übungen werden vorbereitet.",
                          style: trainingModel is TrainingAudioModel
                              ? GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).primaryColor,
                                )
                              : GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(166, 166, 166, 1),
                                ),
                        ),
                        SizedBox(height: 20),
                        Text("Berühre das Display um gleich zu starten"),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 30, left: 30, right: 30),
                      child: Image.asset(
                        "assets/Logo.png",
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
