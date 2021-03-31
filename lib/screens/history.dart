import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/date_machine_util.dart';
import 'package:hatarakujikan_app/helpers/dialog.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/models/user_work.dart';
import 'package:hatarakujikan_app/widgets/custom_history_list_tile.dart';
import 'package:hatarakujikan_app/widgets/custom_month_list_tile.dart';
import 'package:hatarakujikan_app/widgets/custom_total_list_tile.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class HistoryScreen extends StatefulWidget {
  final UserModel user;

  HistoryScreen({@required this.user});

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
    String _started =
        '${DateFormat('yyyy-MM-dd').format(days.first)} 00:00:00.000';
    String _ended =
        '${DateFormat('yyyy-MM-dd').format(days.last)} 23:59:59.999';
    final _startAt = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.parse(_ended).millisecondsSinceEpoch);
    final _endAt = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.parse(_started).millisecondsSinceEpoch);
    final Stream<QuerySnapshot> streamWork = FirebaseFirestore.instance
        .collection('user')
        .doc(widget.user?.id)
        .collection('work')
        .orderBy('startedAt', descending: false)
        .startAt([_startAt]).endAt([_endAt]).snapshots();
    List<UserWorkModel> works = [];

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
              return CustomHistoryListTile(
                day: '${DateFormat('dd (E)', 'ja').format(days[index])}',
                started: '10:00',
                ended: '18:00',
                work: '08:00',
              );
            },
          ),
        ),
        CustomTotalListTile(
          title: '合計時間を確認する',
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
