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
            imageURL:
                "https://firebasestorage.googleapis.com/v0/b/skolio-fa10e.appspot.com/o/MZ_SL_END.png?alt=media&token=f300d2a4-2f7c-4f26-a0b4-d5e29f0633ab",
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
            imageURL:
                "https://firebasestorage.googleapis.com/v0/b/skolio-fa10e.appspot.com/o/zw2St_ASTE.png?alt=media&token=930a1703-c580-45c4-a339-b08831bd5353",
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
            imageURL:
                "https://firebasestorage.googleapis.com/v0/b/skolio-fa10e.appspot.com/o/Segel_ASTE.png?alt=media&token=487fa834-54bc-4b75-af89-77374db8ae03",
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
