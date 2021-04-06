import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/date_machine_util.dart';
import 'package:hatarakujikan_app/helpers/navigation.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/models/user_work.dart';
import 'package:hatarakujikan_app/providers/user_work.dart';
import 'package:hatarakujikan_app/screens/history_details.dart';
import 'package:hatarakujikan_app/screens/total.dart';
import 'package:hatarakujikan_app/widgets/custom_history_list_tile.dart';
import 'package:hatarakujikan_app/widgets/custom_month_button.dart';
import 'package:hatarakujikan_app/widgets/custom_total_button.dart';
import 'package:hatarakujikan_app/widgets/spin_kit.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class HistoryScreen extends StatefulWidget {
  final UserModel user;
  final UserWorkProvider userWorkProvider;

  HistoryScreen({
    @required this.user,
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
              _generateDays(selectMonth);
            });
          },
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: widget.userWorkProvider.userWorkStream(
              userId: widget.user?.id,
              startAt: days.first,
              endAt: days.last,
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SpinKitWidget(size: 32.0);
              }
              List<UserWorkModel> works = [];
              for (DocumentSnapshot data in snapshot.data.docs) {
                works.add(UserWorkModel.fromSnapshot(data));
              }
              return ListView.builder(
                itemCount: days.length,
                itemBuilder: (_, index) {
                  List<UserWorkModel> _dayWorks = [];
                  for (UserWorkModel _work in works) {
                    String _started =
                        DateFormat('yyyy-MM-dd').format(_work.startedAt);
                    if (days[index] == DateTime.parse(_started)) {
                      _dayWorks.add(_work);
                    }
                  }
                  return CustomHistoryListTile(
                    day: days[index],
                    works: _dayWorks,
                    onTap: () {
                      nextScreen(
                          context, HistoryDetailsScreen(day: days[index]));
                    },
                  );
                },
              );
            },
          ),
        ),
        CustomTotalButton(
          title: '合計時間を確認する',
          onTap: () {
            overlayScreen(context, TotalScreen(month: selectMonth));
          },
        ),
      ],
    );
  }
}
