import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skolio/bloc/trainingBloc.dart';
import 'package:skolio/model/trainingModel.dart';
import 'package:skolio/screens/main/training/newTrainingScreen.dart';

class TrainingInfoScreen extends StatefulWidget {
  final TrainingModel trainingModel;

  TrainingInfoScreen(this.trainingModel);

  @override
  _TrainingInfoScreenState createState() => _TrainingInfoScreenState();
}

class _TrainingInfoScreenState extends State<TrainingInfoScreen> {
  TrainingModel _trainingModel;

  @override
  initState() {
    super.initState();
    _trainingModel = widget.trainingModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Übung",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyText1.color,
            fontSize: 16,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          CarouselSlider.builder(
            itemCount: _trainingModel.imageURLs.length,
            itemBuilder: (context, index, index2) => Container(
              height: 177,
              width: 309,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: _trainingModel.imageURLs.first.contains("https:")
                      ? CachedNetworkImageProvider(
                          _trainingModel.imageURLs.first,
                        )
                      : File(_trainingModel.imageURLs.first).existsSync()
                          ? FileImage(File(_trainingModel.imageURLs.first))
                          : AssetImage(
                              "assets/images/${_trainingModel.imageURLs.first}",
                            ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            options: CarouselOptions(
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              height: 177,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _trainingModel.title,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _trainingModel.description,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(166, 166, 166, 1),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(244, 244, 244, 1),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 127,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 239, 226, 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    _trainingModel.repititions.toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Wiederholungen",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              width: 2,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        if (_trainingModel
                                                .pauseBetween.inMinutes !=
                                            0)
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: _trainingModel
                                                    .pauseBetween.inMinutes
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              TextSpan(
                                                text: " m",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: _trainingModel
                                                  .pauseBetween.inSeconds
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                            TextSpan(
                                              text: " s",
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Pause",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (widget.trainingModel.editable)
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              height: 66,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text("Bearbeiten"),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NewTrainingScreen(_trainingModel, updateTrainingModel),
                  ),
                ),
              ),
            ),
          SizedBox(height: 10),
          if (widget.trainingModel.editable)
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              height: 66,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                child: Text(
                  "Löschen",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                onPressed: () {
                  trainingBloc.deleteTraining(_trainingModel.id);
                  Navigator.pop(context);
                },
              ),
            ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  updateTrainingModel(TrainingModel trainingModel) {
    setState(() {
      _trainingModel = trainingModel;
    });
  }
}
