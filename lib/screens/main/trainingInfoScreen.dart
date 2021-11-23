import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:skolio/bloc/authenticationBloc.dart';
import 'package:skolio/bloc/trainingBloc.dart';
import 'package:skolio/model/trainingModel.dart';
import 'package:skolio/screens/main/newTrainingScreen.dart';

class TrainingInfoScreen extends StatefulWidget {
  final TrainingModel trainingModel;

  TrainingInfoScreen(this.trainingModel);

  @override
  _TrainingInfoScreenState createState() => _TrainingInfoScreenState();
}

class _TrainingInfoScreenState extends State<TrainingInfoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Expanded(
            child: Container(),
          ),
          Expanded(
            child: Center(
              child: Text(
                widget.trainingModel.title,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Expanded(
            child: widget.trainingModel.uid ==
                    authenticationBloc.currentUser.valueOrNull.uid
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            trainingBloc
                                .deleteTraining(widget.trainingModel.id);
                            authenticationBloc.removeTrainingFromPlan(
                              widget.trainingModel.id,
                            );
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewTrainingScreen(
                                  widget.trainingModel,
                                  (newTrainingModel) {
                                    setState(() {
                                      widget.trainingModel.title =
                                          newTrainingModel.title;
                                      widget.trainingModel.description =
                                          newTrainingModel.description;
                                      widget.trainingModel.imageURLs =
                                          newTrainingModel.imageURLs;
                                      widget.trainingModel.imageTitle =
                                          newTrainingModel.imageTitle;
                                      widget.trainingModel.repitions =
                                          newTrainingModel.repitions;
                                      widget.trainingModel.sets =
                                          newTrainingModel.sets;
                                      widget.trainingModel.pauseBetween =
                                          newTrainingModel.pauseBetween;
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                : Container(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 50),
            Container(
              child: CarouselSlider(
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  height: MediaQuery.of(context).size.height * 0.5,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                ),
                items: widget.trainingModel.imageURLs
                    .map(
                      (e) => Column(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: e.contains("https")
                                      ? CachedNetworkImageProvider(e)
                                      : AssetImage("assets/images/$e"),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          widget.trainingModel.imageTitle.length !=
                                  widget.trainingModel.imageURLs.length
                              ? Container()
                              : Text(
                                  widget.trainingModel.imageTitle[widget
                                      .trainingModel.imageURLs
                                      .indexWhere((element) => element == e)],
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Beschreibung",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.trainingModel.description,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getImageContainer(String imageURL, String imageTitle) {
    return Container(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.55,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(imageURL),
              ),
            ),
          ),
          Container(
            child: Text(imageTitle),
          ),
        ],
      ),
    );
  }
}
