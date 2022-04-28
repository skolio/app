import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skolio/bloc/authenticationBloc.dart';
import 'package:skolio/bloc/trainingBloc.dart';
import 'package:skolio/model/trainingModel.dart';
import 'package:skolio/screens/main/training/preTrainingScreen.dart';
import 'package:skolio/widgets/general/halfCircleWidget.dart';
import 'package:skolio/widgets/general/scrollBehavior.dart';
import 'package:skolio/widgets/main/training/trainingImageListItem.dart';

class StartTrainingScreen extends StatefulWidget {
  @override
  _StartTrainingScreenState createState() => _StartTrainingScreenState();
}

class _StartTrainingScreenState extends State<StartTrainingScreen> {
  final List<String> _trainingPlan = [];

  @override
  void dispose() {
    super.dispose();
    print("Somehow we disposed the widget here, and i dont know how");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Training starten",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          ScrollConfiguration(
            behavior: OwnScrollBevahior(),
            child: SingleChildScrollView(
              child: Container(
                child: Stack(
                  children: [
                    Container(
                      height:
                          0.75 * (MediaQuery.of(context).size.height * 0.15),
                      width: MediaQuery.of(context).size.width,
                      color: Theme.of(context).primaryColor,
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.only(bottom: 30),
                      child: Text(
                        "Deine Übungen",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.15 * 0.75 -
                            30,
                      ),
                      child: HalfCircle(),
                    ),
                    StreamBuilder(
                      initialData: authenticationBloc.currentUser.valueOrNull,
                      stream: authenticationBloc.currentUser,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) return Container();

                        _trainingPlan.clear();

                        if (snapshot.data.statistic[
                                DateTime.now().toString().split(" ").first] !=
                            null)
                          snapshot.data.trainingPlan.forEach((element) {
                            if (!snapshot
                                .data
                                .statistic[
                                    DateTime.now().toString().split(" ").first]
                                .contains(element)) _trainingPlan.add(element);
                          });
                        else {
                          _trainingPlan.addAll(snapshot.data.trainingPlan);
                        }

                        if (_trainingPlan.length == 0)
                          return Center(
                            child: Container(
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.35,
                              ),
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Text(
                                "Du hast für heute keine Übungen geplant.",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );

                        return DelayedDisplay(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 100),
                            child: Theme(
                              data: ThemeData(
                                splashColor: Colors.transparent,
                                canvasColor: Colors.transparent,
                              ),
                              child: ReorderableListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                cacheExtent:
                                    MediaQuery.of(context).size.height * 2,
                                onReorder: (oldIndex, newIndex) {
                                  setState(() {
                                    final listItem =
                                        _trainingPlan.removeAt(oldIndex);
                                    if (_trainingPlan.length <= newIndex)
                                      newIndex--;
                                    _trainingPlan.insert(newIndex, listItem);
                                    authenticationBloc
                                        .setOrderOfTrainingPlan(_trainingPlan);
                                  });
                                },
                                itemCount: _trainingPlan.length,
                                padding: EdgeInsets.only(top: 100),
                                itemBuilder: (context, index) {
                                  return Container(
                                    key: Key(_trainingPlan[index]),
                                    child: TrainingImageListItem(
                                      trainingModel:
                                          trainingBloc.fetchTrainingModel(
                                              _trainingPlan[index]),
                                      index: index,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              margin: EdgeInsets.only(bottom: 20),
              height: 90,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  "Training starten",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PreTrainingScreen(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
