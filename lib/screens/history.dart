import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/date_machine_util.dart';
import 'package:hatarakujikan_app/helpers/navigation.dart';
import 'package:hatarakujikan_app/models/user_work.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/user_work.dart';
import 'package:hatarakujikan_app/screens/history_details.dart';
import 'package:hatarakujikan_app/widgets/custom_head_list_tile.dart';
import 'package:hatarakujikan_app/widgets/custom_history_list_tile.dart';
import 'package:hatarakujikan_app/widgets/custom_month_button.dart';
import 'package:hatarakujikan_app/widgets/custom_total_button.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class HistoryScreen extends StatefulWidget {
  final UserProvider userProvider;
  final UserWorkProvider userWorkProvider;

  HistoryScreen({
    @required this.userProvider,
    @required this.userWorkProvider,
  });

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime selectMonth = DateTime.now();
  List<DateTime> days = [];

  void _generateDays(DateTime month) async {
    days.clear();
    var _dateMap = DateMachineUtil.getMonthDate(selectMonth, 0);
    DateTime _startAt = DateTime.parse('${_dateMap['start']}');
    DateTime _endAt = DateTime.parse('${_dateMap['end']}');
    for (int i = 0; i <= _endAt.difference(_startAt).inDays; i++) {
      days.add(_startAt.add(Duration(days: i)));
    }
  }

  @override
  void initState() {
    super.initState();
    _generateDays(selectMonth);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomMonthButton(
          month: '${DateFormat('yyyy年MM月分を表示').format(selectMonth)}',
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
              _generateDays(selectMonth);
            });
          },
        ),
        CustomHeadListTile(
          children: [
            Text(
              '出勤時間',
              style: TextStyle(color: Colors.black54, fontSize: 14.0),
            ),
            Text(
              '退勤時間',
              style: TextStyle(color: Colors.black54, fontSize: 14.0),
            ),
            Text(
              '勤務時間',
              style: TextStyle(color: Colors.black54, fontSize: 14.0),
            ),
          ],
        ),
        Expanded(
          child: FutureBuilder<List<UserWorkModel>>(
            future: widget.userWorkProvider.selectList(
              userId: widget.userProvider.user?.id,
              startAt: days.first,
              endAt: days.last,
            ),
            builder: (context, snapshot) {
              List<UserWorkModel> works = [];
              if (snapshot.connectionState == ConnectionState.done) {
                works.clear();
                works = snapshot.data;
              } else {
                works.clear();
              }
              return ListView.builder(
                itemCount: days.length,
                itemBuilder: (_, index) {
                  List<UserWorkModel> _dayWorks = [];
                  for (UserWorkModel _work in works) {
                    if (days[index] ==
                        DateTime.parse(
                            DateFormat('yyyy-MM-dd').format(_work.startedAt))) {
                      _dayWorks.add(_work);
                    }
                  }
                  return CustomHistoryListTile(
                    day: days[index],
                    works: _dayWorks,
                    onTap: () {
                      nextScreen(
                        context,
                        HistoryDetailsScreen(
                          day: days[index],
                          dayWorks: _dayWorks,
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
        CustomTotalButton(
          title: '合計時間を確認',
          onTap: () {},
        ),
      ],
    );
  }
}
