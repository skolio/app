import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skolio/bloc/authenticationBloc.dart';
import 'package:skolio/bloc/trainingBloc.dart';
import 'package:skolio/model/trainingModel.dart';
import 'package:intl/date_symbol_data_local.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: StreamBuilder(
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

          List dateTimes = snapshot.data.statistic.keys.toList();
          dateTimes
              .sort((a, b) => DateTime.parse(b).compareTo(DateTime.parse(a)));

          return ListView.builder(
            itemCount: dateTimes.length,
            itemBuilder: (context, index) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    formatDate(
                      dateTimes[index],
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    top: 10,
                  ),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot
                        .data
                        .statistic[
                            snapshot.data.statistic.keys.elementAt(index)]
                        .length,
                    itemBuilder: (context, itemIndex) {
                      TrainingModel trainingModel = trainingBloc
                          .fetchTrainingModel(snapshot.data.statistic[
                                  snapshot.data.statistic.keys.elementAt(index)]
                              [itemIndex]);

                      formatDate(snapshot.data.statistic.keys.elementAt(index));

                      return Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                child: Text(trainingModel.title),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  formatDate(String date) {
    initializeDateFormatting();
    DateTime dateTime = DateTime.parse(date);
    final DateFormat _dateFormat = DateFormat("EEEE, dd.MM.yyyy", "de_DE");

    return _dateFormat.format(dateTime).toString();
  }
}
