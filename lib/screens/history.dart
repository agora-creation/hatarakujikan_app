import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/date_machine_util.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/widgets/custom_month_list_tile.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime selectMonth = DateTime.now();
  List<DateTime> days = [];

  void _generateDays() {
    var _dateMap = DateMachineUtil.getMonthDate(selectMonth, 0);
    DateTime _start = DateTime.parse(_dateMap['start']);
    DateTime _end = DateTime.parse(_dateMap['end']);
    print(_start);
    print(_end);
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
    return Column(
      children: [
        CustomMonthListTile(
          month: '${DateFormat('yyyy年MM月').format(selectMonth)}',
          onTap: () async {
            var selected = await showMonthPicker(
              context: context,
              initialDate: selectMonth,
              firstDate: DateTime(DateTime.now().year - 1),
              lastDate: DateTime(DateTime.now().year + 1),
            );
            if (selected == null) return;
            setState(() {
              selectMonth = selected;
            });
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: days.length,
            itemBuilder: (_, index) {
              return Container(
                decoration: kBottomBorderDecoration,
                child: ListTile(
                  leading:
                      Text('${DateFormat('dd (E)', 'ja').format(days[index])}'),
                  title: Text(''),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
