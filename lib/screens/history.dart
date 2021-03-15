import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<DateTime> days = [];

  void _generateDays() {
    DateTime _start = DateTime.now();
    DateTime _end = DateTime.now().add(Duration(days: 31));
    final _daysToGenerate = _end.difference(_start).inDays;
    days = List.generate(_daysToGenerate,
        (i) => DateTime(_start.year, _start.month, _start.day + (i)));
  }

  @override
  void initState() {
    super.initState();
    _generateDays();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      children: [
        Text('年月選択'),
        SizedBox(height: 8.0),
        Divider(height: 1.0, color: Colors.grey),
        ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: days.length,
          itemBuilder: (_, index) {
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.0,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              child: ListTile(
                leading:
                    Text('${DateFormat('dd (E)', 'ja').format(days[index])}'),
                title: Text('11:00'),
              ),
            );
          },
        ),
      ],
    );
  }
}
