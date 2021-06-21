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
    String legalText = '0${widget.group?.legal}:00';
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
          print(_work?.startedAt);
          print(_work?.endedAt);
          print(_work?.workTime());
          // 勤務日数
          _count['${DateFormat('yyyy-MM-dd').format(_work?.startedAt)}'] = '';
          // 勤務時間
          _workTime = addTime(_workTime, _work?.workTime());
          // 法定内時間/法定外時間
          List<String> _legalList = legalList(_work?.workTime(), legal);
          _legalTime = addTime(_legalTime, _legalList.first);
          _nonLegalTime = addTime(_nonLegalTime, _legalList.last);
          // 深夜時間
          DateTime _nightStartS = DateTime.parse(
            '${DateFormat('yyyy-MM-dd').format(_work?.startedAt)} $nightStart:00.000',
          );
          DateTime _nightEndS = DateTime.parse(
            '${DateFormat('yyyy-MM-dd').format(_work?.startedAt)} $nightEnd:00.000',
          );
          DateTime _nightStartE = DateTime.parse(
            '${DateFormat('yyyy-MM-dd').format(_work?.endedAt)} $nightStart:00.000',
          );
          DateTime _nightEndE = DateTime.parse(
            '${DateFormat('yyyy-MM-dd').format(_work?.endedAt)} $nightEnd:00.000',
          );
          // 出勤時間が05:00〜22:00
          if (_work.startedAt.millisecondsSinceEpoch >
                  _nightStartS.millisecondsSinceEpoch &&
              _work.startedAt.millisecondsSinceEpoch <
                  _nightEndS.millisecondsSinceEpoch) {
            // 退勤時間が05:00〜22:00
            if (_work.endedAt.millisecondsSinceEpoch >
                    _nightStartE.millisecondsSinceEpoch &&
                _work.endedAt.millisecondsSinceEpoch <
                    _nightEndE.millisecondsSinceEpoch) {
            } else {
              // 退勤時間が22:00〜05:00
            }
          } else {}

          // DateTime _workDayStart;
          // DateTime _workDayEnd;
          // DateTime _workNightStart;
          // DateTime _workNightEnd;
          //退勤時間が05:00〜22:00
          //退勤時間が22:00〜05:00
          //出勤時間が22:00〜05:00
          //退勤時間が05:00〜22:00
          //退勤時間が22:00〜05:00
          // String twoDigits(int n) => n.toString().padLeft(2, '0');
          // Duration _dayDiff = _workDayEnd.difference(_workDayStart);
          // String _dayMinutes = twoDigits(_dayDiff.inMinutes.remainder(60));
          // String _workDayTime = '${twoDigits(_dayDiff.inHours)}:$_dayMinutes';
          // Duration _nightDiff = _workNightEnd.difference(_workNightStart);
          // String _nightMinutes = twoDigits(_nightDiff.inMinutes.remainder(60));
          // String _workNightTime =
          //     '${twoDigits(_nightDiff.inHours)}:$_nightMinutes';
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
