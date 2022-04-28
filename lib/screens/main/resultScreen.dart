import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:skolio/bloc/authenticationBloc.dart';
import 'package:skolio/bloc/trainingBloc.dart';
import 'package:skolio/model/trainingModel.dart';
import 'package:skolio/model/trainingModelInterface.dart';
import 'package:skolio/widgets/main/result/calendarPicker.dart';

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  DateTime _selectedDate = DateTime.now();

  final DateFormat _format = DateFormat("EEEEE, dd. MMMM yyyy", "de");

  final DateFormat _filterFormat = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarPicker(onSelectDate: _onSelectDate),
        SizedBox(),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(""),
              Text(
                _format.format(_selectedDate),
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder(
            initialData: authenticationBloc.currentUser.valueOrNull,
            stream: authenticationBloc.currentUser,
            builder: (context, snapshot) {
              if (snapshot.data == null)
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                );
              print("We are getting some new Data here");
              List ids =
                  snapshot.data.statistic[_filterFormat.format(_selectedDate)];

              if (ids == null || ids.length == 0)
                return Center(
                  child: Text("Es gibt keine Daten zu diesem Datum"),
                );

              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Details",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: ListView.builder(
                          itemCount: ids.length,
                          itemBuilder: (context, index) {
                            final TrainingModelInterface trainingModel =
                                trainingBloc.fetchTrainingModel(
                              ids[index],
                            );

                            return Container(
                              margin: EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                              ),
                              padding: EdgeInsets.only(
                                top: 15,
                                bottom: 10,
                                left: 20,
                                right: 20,
                              ),
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
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          trainingModel.title,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Abgeschlosssen",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/greenCheck.svg",
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Übung abgeschlossen",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  _onSelectDate(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
    });
  }
}
