import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/work.dart';
import 'package:hatarakujikan_app/widgets/custom_list_tile.dart';

class HistoryTotal extends StatelessWidget {
  final UserProvider userProvider;
  final WorkProvider workProvider;

  HistoryTotal({
    required this.userProvider,
    required this.workProvider,
  });

  @override
  Widget build(BuildContext context) {
    GroupModel? _group = userProvider.group;
    UserModel? _user = userProvider.user;
    List<WorkModel> works = [];
    Map _cnt = {};
    int workDays = 0;
    String workTimes = '00:00';
    String legalTimes = '00:00';
    String nonLegalTimes = '00:00';
    String nightTimes = '00:00';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          '${dateText('yyyy年MM月', workProvider.days.first)}の集計',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: workProvider.streamList(groupId: _group?.id, userId: _user?.id),
        builder: (context, snapshot) {
          works.clear();
          if (snapshot.hasData) {
            for (DocumentSnapshot<Map<String, dynamic>> doc
                in snapshot.data!.docs) {
              works.add(WorkModel.fromSnapshot(doc));
            }
          }
          for (WorkModel _work in works) {
            if (_work.startedAt != _work.endedAt) {
              String _key = dateText('yyyy-MM-dd', _work.startedAt);
              _cnt[_key] = '';
              workTimes = addTime(workTimes, _work.workTime());
              List<String> _legalTimes = _work.legalTimes(_group);
              legalTimes = addTime(legalTimes, _legalTimes.first);
              nonLegalTimes = addTime(nonLegalTimes, _legalTimes.last);
              List<String> _nightTimes = _work.nightTimes(_group);
              nightTimes = addTime(nightTimes, _nightTimes.last);
            }
          }
          workDays = _cnt.length;
          return ListView(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            children: [
              CustomListTile(
                label: '会社/組織名',
                value: _group?.name,
              ),
              CustomListTile(
                label: '総勤務日数',
                value: '$workDays日',
              ),
              CustomListTile(
                label: '総勤務時間',
                value: workTimes,
              ),
              CustomListTile(
                label: '総法定内時間',
                value: legalTimes,
              ),
              CustomListTile(
                label: '総法定外時間',
                value: nonLegalTimes,
              ),
              CustomListTile(
                label: '総深夜時間',
                value: nightTimes,
              ),
            ],
          );
        },
      ),
    );
  }
}
