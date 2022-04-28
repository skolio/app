import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skolio/screens/main/training/startTrainingScreen.dart';
import 'package:skolio/screens/main/training/trainingPlanScreen.dart';
import 'package:skolio/widgets/general/halfCircleWidget.dart';
import 'package:skolio/widgets/main/mainScreenItem.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double _height = 1.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _height = 0.75;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DelayedDisplay(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.15 * _height,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 70),
                Expanded(
                  flex: 6,
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StartTrainingScreen(),
                      ),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: MainScreenItem(
                        title: "Training starten",
                        description: "Jetzt trainieren",
                        icon: "assets/icons/A.png",
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  flex: 3,
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrainingPlanScreen(),
                      ),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: MainScreenItem(
                        title: "Trainingsplan",
                        description: "Plane jetzt deine Übungen",
                        icon: "assets/icons/B.png",
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          curve: Curves.fastOutSlowIn,
          duration: Duration(seconds: 1),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.15 * _height - 30,
          ),
          child: HalfCircle(),
        ),
        AnimatedContainer(
          curve: Curves.fastOutSlowIn,
          duration: Duration(seconds: 1),
          height: _height * (MediaQuery.of(context).size.height * 0.15),
          width: MediaQuery.of(context).size.width,
          child: Container(
            color: Theme.of(context).primaryColor,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.15,
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(bottom: 5, left: 30),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset("assets/icons/panda.svg"),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Moin!",
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Willkommen bei Skolio!",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                SvgPicture.asset(
                  "assets/icons/panda.svg",
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
