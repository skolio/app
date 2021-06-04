import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:skolio/model/trainingModel.dart';

class TrainingInfoScreen extends StatefulWidget {
  final TrainingModel trainingModel;

  TrainingInfoScreen(this.trainingModel);

  @override
  _TrainingInfoScreenState createState() => _TrainingInfoScreenState();
}

class _TrainingInfoScreenState extends State<TrainingInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.trainingModel.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 50),
            Container(
              child: CarouselSlider(
                options: CarouselOptions(
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
                                  image: CachedNetworkImageProvider(e),
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
