import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skolio/model/trainingModel.dart';
import 'package:skolio/screens_new/main/training/trainingInfoScreen.dart';

class TrainingImageListItem extends StatefulWidget {
  final TrainingModel trainingModel;
  final int index;

  TrainingImageListItem({@required this.trainingModel, @required this.index});

  @override
  _TrainingImageListItemState createState() => _TrainingImageListItemState();
}

class _TrainingImageListItemState extends State<TrainingImageListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrainingInfoScreen(widget.trainingModel),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 10, top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: widget.trainingModel.imageURLs.isEmpty
                ? AssetImage("assets/icons/B.png")
                : widget.trainingModel.imageURLs.first.contains("https:")
                    ? CachedNetworkImageProvider(
                        widget.trainingModel.imageURLs.first,
                      )
                    : File(widget.trainingModel.imageURLs.first).existsSync()
                        ? FileImage(File(widget.trainingModel.imageURLs.first))
                        : AssetImage(
                            "assets/images/${widget.trainingModel.imageURLs.first}",
                          ),
            fit: BoxFit.cover,
          ),
        ),
        height: 155,
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.trainingModel.title.toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${widget.trainingModel.repitions.toString()} x ${widget.trainingModel.sets.toString()}",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Container(
                width: 50,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white.withOpacity(0.85),
                ),
                alignment: Alignment.center,
                child: Text(
                  (widget.index + 1).toString(),
                  style: GoogleFonts.poppins(
                    color: Color.fromRGBO(235, 122, 0, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
