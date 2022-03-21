import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/dialogs.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/work.dart';

class HistoryTotal extends StatefulWidget {
  final UserProvider userProvider;
  final WorkProvider workProvider;
  final List<DateTime> days;
  final GroupModel group;

  HistoryTotal({
    required this.userProvider,
    required this.workProvider,
    required this.days,
    required this.group,
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
    await versionCheck().then((value) {
      if (!value) return;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => UpdaterDialog(),
      );
    });
    await widget.workProvider
        .selectList(
      group: widget.userProvider.group!,
      user: widget.userProvider.user!,
      startAt: widget.days.first,
      endAt: widget.days.last,
    )
        .then((value) {
      Map _count = {};
      int _workCount = 0;
      String _workTime = '00:00';
      String _legalTime = '00:00';
      String _nonLegalTime = '00:00';
      String _nightTime = '00:00';
      for (WorkModel _work in value) {
        if (_work.startedAt != _work.endedAt) {
          String _key = dateText('yyyy-MM-dd', _work.startedAt);
          _count[_key] = '';
          _workTime = addTime(_workTime, _work.workTime());
          List<String> _legalTimes = _work.legalTimes(widget.group);
          _legalTime = addTime(_legalTime, _legalTimes.first);
          _nonLegalTime = addTime(_nonLegalTime, _legalTimes.last);
          List<String> _nightTimes = _work.nightTimes(widget.group);
          _nightTime = addTime(_nightTime, _nightTimes.last);
        }
      }
      _workCount = _count.length;
      setState(() {
        workCount = _workCount;
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
          '${dateText('yyyy年MM月', widget.days.first)}の集計',
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
          Container(
            decoration: kBottomBorderDecoration,
            child: ListTile(
              title: Text('会社/組織'),
              trailing: Text(widget.group.name),
            ),
          ),
          Container(
            decoration: kBottomBorderDecoration,
            child: ListTile(
              title: Text('総勤務日数'),
              trailing: Text('$workCount 日'),
            ),
          ),
          Container(
            decoration: kBottomBorderDecoration,
            child: ListTile(
              title: Text('総勤務時間'),
              trailing: Text(workTime),
            ),
          ),
          Container(
            decoration: kBottomBorderDecoration,
            child: ListTile(
              title: Text('総法定内時間'),
              trailing: Text(legalTime),
            ),
          ),
          Container(
            decoration: kBottomBorderDecoration,
            child: ListTile(
              title: Text('総法定外時間'),
              trailing: Text(nonLegalTime),
            ),
          ),
          Container(
            decoration: kBottomBorderDecoration,
            child: ListTile(
              title: Text('総深夜時間'),
              trailing: Text(nightTime),
            ),
          ),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }
}
