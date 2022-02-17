import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarPicker extends StatefulWidget {
  final Function(DateTime) onSelectDate;

  CalendarPicker({@required this.onSelectDate});

  @override
  _CalendarPickerState createState() => _CalendarPickerState();
}

class _CalendarPickerState extends State<CalendarPicker> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _initialScroll(),
    );
  }

  _initialScroll() {
    _selectedIndex = 182;
    _scrollController.animateTo(
      _selectedIndex * 85.0 - MediaQuery.of(context).size.width * 0.5 + 45,
      duration: Duration(milliseconds: 250),
      curve: Curves.easeInOutCubic,
    );
  }

  int _selectedIndex = 0;

  DateFormat _format = DateFormat("E", "de-DE");

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      height: 80,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: 365,
        itemBuilder: (context, index) {
          DateTime now;

          if (index <= 182)
            now = DateTime.now().subtract(Duration(days: 182 - index));
          else
            now = DateTime.now().add(Duration(days: index - 182));

          return InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              _scrollController.animateTo(
                index * 85.0 - MediaQuery.of(context).size.width * 0.5 + 45,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOutCubic,
              );
              widget.onSelectDate(now);
              _selectedIndex = index;
              setState(() {});
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOutCubic,
              width: 65,
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
                bottom: 10,
              ),
              decoration: BoxDecoration(
                color: index == _selectedIndex
                    ? Theme.of(context).primaryColor
                    : Color.fromRGBO(241, 243, 250, 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Text(
                      _format.format(now),
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400,
                        color: index == _selectedIndex
                            ? Colors.white
                            : Color.fromRGBO(159, 162, 174, 1),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Text(
                      now.day.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: index == _selectedIndex
                            ? Colors.white
                            : Color.fromRGBO(43, 43, 43, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
