import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/models/work_shift.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/work.dart';
import 'package:hatarakujikan_app/screens/group_select.dart';
import 'package:hatarakujikan_app/screens/history_button.dart';
import 'package:hatarakujikan_app/screens/history_total.dart';
import 'package:hatarakujikan_app/widgets/expanded_button.dart';
import 'package:hatarakujikan_app/widgets/history_header.dart';
import 'package:hatarakujikan_app/widgets/history_list.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';

class HistoryScreen extends StatelessWidget {
  final UserProvider userProvider;
  final WorkProvider workProvider;

  HistoryScreen({
    required this.userProvider,
    required this.workProvider,
  });

  @override
  Widget build(BuildContext context) {
    GroupModel? _group = userProvider.group;
    UserModel? _user = userProvider.user;
    List<WorkModel> works = [];
    List<WorkShiftModel> workShifts = [];

    if (_group == null) return Center(child: Text('会社/組織に所属していません'));
    if (_user == null) return Container();
    return Column(
      children: [
        ExpandedButton(
          backgroundColor: Colors.blueGrey,
          label: _group.name,
          color: Colors.white,
          leading: Icon(Icons.store, color: Colors.white),
          trailing: Icon(Icons.arrow_drop_down, color: Colors.white),
          onTap: () => overlayScreen(
            context,
            GroupSelect(userProvider: userProvider),
          ),
        ),
        HistoryButton(
          monthOnPressed: () async {
            DateTime? selected = await customMonthPicker(
              context: context,
              init: workProvider.month,
            );
            if (selected == null) return;
            workProvider.changeMonth(selected);
          },
          totalOnPressed: () => overlayScreen(
            context,
            HistoryTotal(
              userProvider: userProvider,
              workProvider: workProvider,
            ),
          ),
          month: dateText('yyyy年MM月', workProvider.month),
        ),
        HistoryHeader(),
        Expanded(
          child: StreamBuilder2<QuerySnapshot<Map<String, dynamic>>,
              QuerySnapshot<Map<String, dynamic>>>(
            streams: Tuple2(
              workProvider.streamList(
                groupId: _group.id,
                userId: _user.id,
              ),
              workProvider.streamListShift(
                groupId: _group.id,
                userId: _user.id,
              ),
            ),
            builder: (context, snapshot) {
              works.clear();
              if (snapshot.item1.hasData) {
                for (DocumentSnapshot<Map<String, dynamic>> doc
                    in snapshot.item1.data!.docs) {
                  works.add(WorkModel.fromSnapshot(doc));
                }
              }
              workShifts.clear();
              if (snapshot.item2.hasData) {
                for (DocumentSnapshot<Map<String, dynamic>> doc
                    in snapshot.item2.data!.docs) {
                  workShifts.add(WorkShiftModel.fromSnapshot(doc));
                }
              }
              return ListView.builder(
                itemCount: workProvider.days.length,
                itemBuilder: (_, index) {
                  List<WorkModel> _dayInWorks = [];
                  for (WorkModel _work in works) {
                    String _key = dateText('yyyy-MM-dd', _work.startedAt);
                    if (workProvider.days[index] == DateTime.parse(_key)) {
                      _dayInWorks.add(_work);
                    }
                  }
                  WorkShiftModel? _dayInWorkShift;
                  for (WorkShiftModel _workShift in workShifts) {
                    String _key = dateText('yyyy-MM-dd', _workShift.startedAt);
                    if (workProvider.days[index] == DateTime.parse(_key)) {
                      _dayInWorkShift = _workShift;
                    }
                  }
                  return HistoryList(
                    user: _user,
                    day: workProvider.days[index],
                    dayInWorks: _dayInWorks,
                    dayInWorkShift: _dayInWorkShift,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
