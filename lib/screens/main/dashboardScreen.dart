import 'package:flutter/material.dart';
import 'package:skolio/widgets/main/dashboardItem.dart';

class DashboardScreen extends StatefulWidget {
  final Function(int) changeCurrentScreen;

  DashboardScreen(this.changeCurrentScreen);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            DashboardItem(
              imageURL: "MZ_SL_END.png",
              title: "Trainingsplan",
              bodyText: "Erstelle deinen Trainingsplan",
              onTap: () {
                widget.changeCurrentScreen(1);
              },
              buttonWidget: Icon(
                Icons.settings,
                color: Theme.of(context).primaryColor,
                size: 25,
              ),
            ),
            SizedBox(height: 20),
            DashboardItem(
              imageURL: "zw2St_ASTE.png",
              title: "Training starten",
              bodyText: "Starte jetzt dein Training",
              onTap: () {
                widget.changeCurrentScreen(2);
              },
              buttonWidget: Icon(
                Icons.favorite,
                color: Theme.of(context).primaryColor,
                size: 25,
              ),
            ),
            SizedBox(height: 20),
            DashboardItem(
              imageURL: "Segel_ASTE.png",
              title: "Deine Erfolge",
              bodyText: "Verfole deine Entwicklung",
              onTap: () {
                widget.changeCurrentScreen(3);
              },
              buttonWidget: Icon(
                Icons.show_chart,
                color: Theme.of(context).primaryColor,
                size: 25,
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
