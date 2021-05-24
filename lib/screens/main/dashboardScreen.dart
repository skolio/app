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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          DashboardItem(
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
            title: "Deine Erfolge",
            bodyText: "Starte jetzt dein Training",
            onTap: () {
              widget.changeCurrentScreen(3);
            },
            buttonWidget: Icon(
              Icons.show_chart,
              color: Theme.of(context).primaryColor,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
