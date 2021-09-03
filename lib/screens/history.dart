import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/models/work_state.dart';
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
import 'package:multiple_stream_builder/multiple_stream_builder.dart';

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
  DateTime month = DateTime.now();
  List<DateTime> days = [];

  void _init() async {
    setState(() => days = generateDays(month));
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    Timestamp _startAt = Timestamp.fromMillisecondsSinceEpoch(DateTime.parse(
      '${DateFormat('yyyy-MM-dd').format(days.first)} 00:00:00.000',
    ).millisecondsSinceEpoch);
    Timestamp _endAt = Timestamp.fromMillisecondsSinceEpoch(DateTime.parse(
      '${DateFormat('yyyy-MM-dd').format(days.last)} 23:59:59.999',
    ).millisecondsSinceEpoch);
    Stream<QuerySnapshot> _streamWork = FirebaseFirestore.instance
        .collection('work')
        .where('groupId', isEqualTo: widget.userProvider.group?.id ?? 'error')
        .where('userId', isEqualTo: widget.userProvider.user?.id ?? 'error')
        .orderBy('startedAt', descending: false)
        .startAt([_startAt]).endAt([_endAt]).snapshots();
    Stream<QuerySnapshot> _streamWorkState = FirebaseFirestore.instance
        .collection('workState')
        .where('groupId', isEqualTo: widget.userProvider.group?.id ?? 'error')
        .where('userId', isEqualTo: widget.userProvider.user?.id ?? 'error')
        .orderBy('startedAt', descending: false)
        .startAt([_startAt]).endAt([_endAt]).snapshots();
    List<WorkModel> works = [];
    List<WorkStateModel> workStates = [];

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
                    initialDate: month,
                    firstDate: kMonthFirstDate,
                    lastDate: kMonthLastDate,
                  );
                  if (selected == null) return;
                  setState(() {
                    month = selected;
                    days = generateDays(month);
                  });
                },
                totalOnPressed: () => overlayScreen(
                  context,
                  HistoryTotal(
                    userProvider: widget.userProvider,
                    workProvider: widget.workProvider,
                    days: days,
                    group: widget.userProvider.group,
                  ),
                ),
                month: '${DateFormat('yyyy年MM月').format(month)}',
              ),
              CustomHeadListTile(),
              Expanded(
                child: StreamBuilder2<QuerySnapshot, QuerySnapshot>(
                  streams: Tuple2(_streamWork, _streamWorkState),
                  builder: (context, snapshot) {
                    if (!snapshot.item1.hasData || !snapshot.item2.hasData) {
                      return Loading(color: Colors.cyan);
                    }
                    works.clear();
                    for (DocumentSnapshot doc in snapshot.item1.data.docs) {
                      works.add(WorkModel.fromSnapshot(doc));
                    }
                    workStates.clear();
                    for (DocumentSnapshot doc in snapshot.item2.data.docs) {
                      workStates.add(WorkStateModel.fromSnapshot(doc));
                    }
                    return ListView.builder(
                      itemCount: days.length,
                      itemBuilder: (_, index) {
                        List<WorkModel> dayWorks = [];
                        for (WorkModel _work in works) {
                          String _start =
                              '${DateFormat('yyyy-MM-dd').format(_work.startedAt)}';
                          if (days[index] == DateTime.parse(_start)) {
                            dayWorks.add(_work);
                          }
                        }
                        WorkStateModel dayWorkState;
                        for (WorkStateModel _workState in workStates) {
                          String _start =
                              '${DateFormat('yyyy-MM-dd').format(_workState.startedAt)}';
                          if (days[index] == DateTime.parse(_start)) {
                            dayWorkState = _workState;
                          }
                        }
                        return CustomHistoryListTile(
                          user: widget.userProvider.user,
                          day: days[index],
                          dayWorks: dayWorks,
                          dayWorkState: dayWorkState,
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
