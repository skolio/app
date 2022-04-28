import 'package:flutter/material.dart';
import 'package:skolio/widgets/general/halfCircleWidget.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class PauseScreen extends StatefulWidget {
  @override
  State<PauseScreen> createState() => _PauseScreenState();
}

class _PauseScreenState extends State<PauseScreen> {
  StopWatchTimer _stopWatchTimer;

  @override
  void initState() {
    super.initState();

    _stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countDown,
      onEnded: () {
        Navigator.pop(context);
      },
    );

    _stopWatchTimer.setPresetSecondTime(30);
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                  height: 350,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "Pause",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 150,
                        width: 150,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        child: StreamBuilder(
                          stream: _stopWatchTimer.rawTime,
                          builder: (context, snapshot) {
                            if (snapshot.data == null)
                              return Text(
                                "00:00",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                ),
                              );

                            final displayTime =
                                StopWatchTimer.getDisplayTime(snapshot.data);

                            return Text(
                              displayTime.substring(3, 8),
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
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
                          child: Text("Weiter"),
                          onPressed: _onTapNext,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 30,
                      left: 50,
                      right: 50,
                      top: 20,
                    ),
                    child: Image.asset(
                      "assets/Logo.png",
                      width: MediaQuery.of(context).size.width * 0.6,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _onTapNext() {
    Navigator.pop(context);
  }
}
