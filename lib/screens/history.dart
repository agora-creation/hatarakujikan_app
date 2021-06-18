import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/date_machine_util.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/work.dart';
import 'package:hatarakujikan_app/screens/group_select.dart';
import 'package:hatarakujikan_app/screens/history_button.dart';
import 'package:hatarakujikan_app/screens/history_total.dart';
import 'package:hatarakujikan_app/widgets/custom_expanded_button.dart';
import 'package:hatarakujikan_app/widgets/custom_head_list_tile.dart';
import 'package:hatarakujikan_app/widgets/custom_history_list_tile.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class HistoryScreen extends StatefulWidget {
  final UserProvider userProvider;
  final WorkProvider workProvider;

  HistoryScreen({
    @required this.userProvider,
    @required this.workProvider,
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
    Timestamp _startAt = Timestamp.fromMillisecondsSinceEpoch(DateTime.parse(
            '${DateFormat('yyyy-MM-dd').format(days.first)} 00:00:00.000')
        .millisecondsSinceEpoch);
    Timestamp _endAt = Timestamp.fromMillisecondsSinceEpoch(DateTime.parse(
            '${DateFormat('yyyy-MM-dd').format(days.last)} 23:59:59.999')
        .millisecondsSinceEpoch);
    Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
        .collection('work')
        .where('groupId', isEqualTo: widget.userProvider.group?.id)
        .where('userId', isEqualTo: widget.userProvider.user?.id)
        .orderBy('startedAt', descending: false)
        .startAt([_startAt]).endAt([_endAt]).snapshots();
    List<WorkModel> works = [];

    return widget.userProvider.group != null
        ? Column(
            children: [
              CustomExpandedButton(
                onTap: () => overlayScreen(
                  context,
                  GroupSelect(userProvider: widget.userProvider),
                ),
                backgroundColor: Colors.blueGrey,
                label: widget.userProvider.group?.name ?? '',
                color: Colors.white,
                leading: Icon(Icons.store, color: Colors.white),
                trailing: Icon(Icons.arrow_drop_down, color: Colors.white),
              ),
              HistoryButton(
                monthOnPressed: () async {
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
                totalOnPressed: () => overlayScreen(
                  context,
                  HistoryTotal(
                    userProvider: widget.userProvider,
                    workProvider: widget.workProvider,
                    days: days,
                  ),
                ),
                selectMonth: '${DateFormat('yyyy年MM月').format(selectMonth)}',
              ),
              CustomHeadListTile(),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Loading(color: Colors.cyan);
                    }
                    works.clear();
                    for (DocumentSnapshot work in snapshot.data.docs) {
                      works.add(WorkModel.fromSnapshot(work));
                    }
                    return ListView.builder(
                      itemCount: days.length,
                      itemBuilder: (_, index) {
                        List<WorkModel> _dayWorks = [];
                        for (WorkModel _work in works) {
                          DateTime _tmp = DateTime.parse(
                            DateFormat('yyyy-MM-dd').format(_work.startedAt),
                          );
                          if (days[index] == _tmp) {
                            _dayWorks.add(_work);
                          }
                        }
                        return CustomHistoryListTile(
                          user: widget.userProvider.user,
                          day: days[index],
                          works: _dayWorks,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          )
        : Center(child: Text('会社/組織に所属していません'));
  }
}
