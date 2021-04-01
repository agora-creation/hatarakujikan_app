import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ApplyScreen extends StatefulWidget {
  @override
  _ApplyScreenState createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  DateTime selectMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCalendar(
        view: CalendarView.month,
        initialSelectedDate: DateTime.now(),
        showNavigationArrow: true,
        monthViewSettings: MonthViewSettings(showAgenda: true),
      ),
    );
  }
}
