import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/work.dart';
import 'package:hatarakujikan_app/widgets/custom_history_details_list_tile.dart';
import 'package:intl/intl.dart';

class HistoryTotal extends StatefulWidget {
  final UserProvider userProvider;
  final WorkProvider workProvider;
  final List<DateTime> days;
  final GroupModel group;

  HistoryTotal({
    @required this.userProvider,
    @required this.workProvider,
    @required this.days,
    @required this.group,
  });

  @override
  _HistoryTotalState createState() => _HistoryTotalState();
}

class _HistoryTotalState extends State<HistoryTotal> {
  int workCount = 0;
  String workTime = '00:00';
  String legalTime = '00:00';
  String nonLegalTime = '00:00';
  String nightTime = '00:00';

  void _init() async {
    int legal = widget.group?.legal;
    String nightStart = widget.group?.nightStart;
    String nightEnd = widget.group?.nightEnd;
    await widget.workProvider
        .selectList(
      groupId: widget.userProvider.group?.id,
      userId: widget.userProvider.user?.id,
      startAt: widget.days.first,
      endAt: widget.days.last,
    )
        .then((value) {
      Map _count = {};
      String _workTime = '00:00';
      String _legalTime = '00:00';
      String _nonLegalTime = '00:00';
      String _nightTime = '00:00';
      for (WorkModel _work in value) {
        if (_work?.startedAt != _work?.endedAt) {
          // 勤務日数
          _count['${DateFormat('yyyy-MM-dd').format(_work?.startedAt)}'] = '';
          // 勤務時間
          _workTime = addTime(_workTime, _work?.workTime());
          // 法定内時間/法定外時間
          List<String> _legalList = legalList(
            workTime: _work?.workTime(),
            legal: legal,
          );
          _legalTime = addTime(_legalTime, _legalList.first);
          _nonLegalTime = addTime(_nonLegalTime, _legalList.last);
          // 深夜時間
          List<String> _nightList = nightList(
            startedAt: _work?.startedAt,
            endedAt: _work?.endedAt,
            nightStart: nightStart,
            nightEnd: nightEnd,
          );
          _nightTime = addTime(_nightTime, _nightList.last);
        }
      }
      setState(() {
        workCount = _count.length;
        workTime = _workTime;
        legalTime = _legalTime;
        nonLegalTime = _nonLegalTime;
        nightTime = _nightTime;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          '${DateFormat('yyyy年MM月').format(widget.days.first)}の集計',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          CustomHistoryDetailsListTile(
            icon: null,
            label: '会社/組織',
            time: widget.userProvider.group?.name ?? '',
          ),
          CustomHistoryDetailsListTile(
            icon: null,
            label: '勤務日数',
            time: '$workCount 日',
          ),
          CustomHistoryDetailsListTile(
            icon: null,
            label: '勤務時間',
            time: workTime,
          ),
          CustomHistoryDetailsListTile(
            icon: null,
            label: '法定内時間',
            time: legalTime,
          ),
          CustomHistoryDetailsListTile(
            icon: null,
            label: '法定外時間',
            time: nonLegalTime,
          ),
          CustomHistoryDetailsListTile(
            icon: null,
            label: '深夜時間',
            time: nightTime,
          ),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }
}
