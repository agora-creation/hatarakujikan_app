import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/models/work_shift.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/work.dart';
import 'package:hatarakujikan_app/screens/group_select.dart';
import 'package:hatarakujikan_app/screens/history_button.dart';
import 'package:hatarakujikan_app/screens/history_total.dart';
import 'package:hatarakujikan_app/widgets/custom_expanded_button.dart';
import 'package:hatarakujikan_app/widgets/custom_head_list_tile.dart';
import 'package:hatarakujikan_app/widgets/custom_history_list_tile.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';

class HistoryScreen extends StatefulWidget {
  final UserProvider userProvider;
  final WorkProvider workProvider;

  HistoryScreen({
    required this.userProvider,
    required this.workProvider,
  });

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime _month = DateTime.now();
  List<DateTime> _days = [];

  void _init() async {
    setState(() => _days = generateDays(_month));
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    GroupModel _group = widget.userProvider.group!;
    UserModel _user = widget.userProvider.user!;
    Timestamp _startAt = convertTimestamp(_days.first, false);
    Timestamp _endAt = convertTimestamp(_days.last, true);
    Stream<QuerySnapshot<Map<String, dynamic>>> _streamWork = FirebaseFirestore
        .instance
        .collection('work')
        .where('groupId', isEqualTo: _group.id)
        .where('userId', isEqualTo: _user.id)
        .orderBy('startedAt', descending: false)
        .startAt([_startAt]).endAt([_endAt]).snapshots();
    Stream<QuerySnapshot<Map<String, dynamic>>> _streamWorkShift =
        FirebaseFirestore.instance
            .collection('workShift')
            .where('groupId', isEqualTo: _group.id)
            .where('userId', isEqualTo: _user.id)
            .orderBy('startedAt', descending: false)
            .startAt([_startAt]).endAt([_endAt]).snapshots();
    List<WorkModel> _works = [];
    List<WorkShiftModel> _workShifts = [];

    return _group.id != ''
        ? Column(
            children: [
              CustomExpandedButton(
                onTap: () => overlayScreen(
                  context,
                  GroupSelect(userProvider: widget.userProvider),
                ),
                backgroundColor: Colors.blueGrey,
                label: _group.name,
                color: Colors.white,
                leading: Icon(Icons.store, color: Colors.white),
                trailing: Icon(Icons.arrow_drop_down, color: Colors.white),
              ),
              HistoryButton(
                monthOnPressed: () async {
                  var selected = await showMonthPicker(
                    context: context,
                    initialDate: _month,
                    firstDate: kMonthFirstDate,
                    lastDate: kMonthLastDate,
                  );
                  if (selected == null) return;
                  setState(() {
                    _month = selected;
                    _days = generateDays(_month);
                  });
                },
                totalOnPressed: () => overlayScreen(
                  context,
                  HistoryTotal(
                    userProvider: widget.userProvider,
                    workProvider: widget.workProvider,
                    days: _days,
                    group: _group,
                  ),
                ),
                month: dateText('yyyy年MM月', _month),
              ),
              CustomHeadListTile(),
              Expanded(
                child: StreamBuilder2<QuerySnapshot<Map<String, dynamic>>,
                    QuerySnapshot<Map<String, dynamic>>>(
                  streams: Tuple2(_streamWork, _streamWorkShift),
                  builder: (context, snapshot) {
                    _works.clear();
                    if (snapshot.item1.hasData) {
                      for (DocumentSnapshot<Map<String, dynamic>> doc
                          in snapshot.item1.data!.docs) {
                        _works.add(WorkModel.fromSnapshot(doc));
                      }
                    }
                    _workShifts.clear();
                    if (snapshot.item2.hasData) {
                      for (DocumentSnapshot<Map<String, dynamic>> doc
                          in snapshot.item2.data!.docs) {
                        _workShifts.add(WorkShiftModel.fromSnapshot(doc));
                      }
                    }
                    return ListView.builder(
                      itemCount: _days.length,
                      itemBuilder: (_, index) {
                        List<WorkModel> _dayWorks = [];
                        for (WorkModel _work in _works) {
                          String _start = dateText(
                            'yyyy-MM-dd',
                            _work.startedAt,
                          );
                          if (_days[index] == DateTime.parse(_start)) {
                            _dayWorks.add(_work);
                          }
                        }
                        WorkShiftModel? _dayWorkShift;
                        for (WorkShiftModel _workShift in _workShifts) {
                          String _start = dateText(
                            'yyyy-MM-dd',
                            _workShift.startedAt,
                          );
                          if (_days[index] == DateTime.parse(_start)) {
                            _dayWorkShift = _workShift;
                          }
                        }
                        return CustomHistoryListTile(
                          user: widget.userProvider.user,
                          day: _days[index],
                          dayWorks: _dayWorks,
                          dayWorkShift: _dayWorkShift,
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
