import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/date_machine_util.dart';
import 'package:hatarakujikan_app/helpers/dialog.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/widgets/custom_month_list_tile.dart';
import 'package:hatarakujikan_app/widgets/custom_total_list_tile.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime selectMonth = DateTime.now();
  List<DateTime> days = [];

  List<DateTime> _generateDays(DateTime month) {
    days.clear();
    List<DateTime> _days = [];
    var _dateMap = DateMachineUtil.getMonthDate(selectMonth, 0);
    DateTime _start = DateTime.parse('${_dateMap['start']}');
    DateTime _end = DateTime.parse('${_dateMap['end']}');
    for (int i = 0; i <= _end.difference(_start).inDays; i++) {
      _days.add(_start.add(Duration(days: i)));
    }
    return _days;
  }

  @override
  void initState() {
    super.initState();
    days = _generateDays(selectMonth);
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
              days = _generateDays(selectMonth);
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
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '出勤時間',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                          Text('11:00'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '退勤時間',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                          Text('11:00'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '勤務時間',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                          Text('11:00'),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        CustomTotalListTile(
          title: '合計を確認する',
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => WorkTotalDialog(),
            );
          },
        ),
      ],
    );
  }
}
