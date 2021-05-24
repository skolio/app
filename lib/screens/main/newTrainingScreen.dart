import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skolio/widgets/authentication/ownTextField.dart';

class NewTrainingScreen extends StatefulWidget {
  @override
  _NewTrainingScreenState createState() => _NewTrainingScreenState();
}

class _NewTrainingScreenState extends State<NewTrainingScreen> {
  final _nameController = TextEditingController();

  int setCount = 0;
  int duration = 0;

  List<String> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ÜBUNG ERSTELLEN"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: Column(
          children: [
            SizedBox(height: 20),
            OwnTextField(
              controller: _nameController,
              hintTitle: "Übungsname",
              obscureText: false,
            ),
            SizedBox(height: 20),
            CarouselSlider(
              options: CarouselOptions(enlargeCenterPage: true),
              items: List<Widget>.from(images
                  .map(
                    (e) => Container(
                      width: MediaQuery.of(context).size.width,
                    ),
                  )
                  .toList())
                ..add(
                  InkWell(
                    onTap: onTapAddImage,
                    child: Container(
                      child: Center(
                        child: Icon(
                          Icons.add,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          "Wiederholungen",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Icon(
                                Icons.remove,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (setCount != 0) setCount--;
                                });
                              },
                            ),
                            Text(
                              setCount.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Icon(
                                Icons.add,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  setCount++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onTapDuration,
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          "Dauer",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Container(),
                              onPressed: null,
                            ),
                            Text(
                              "0",
                              style: TextStyle(fontSize: 18),
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Container(),
                              onPressed: null,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              child: Text("SPEICHERN"),
              onPressed: () {
                print("");
              },
            ),
          ],
        ),
      ),
    );
  }

  onTapAddImage() {
    print("On Tap Image");
  }

  onTapDuration() {}
}
