import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/work.dart';
import 'package:hatarakujikan_app/widgets/custom_history_details_list_tile.dart';
import 'package:intl/intl.dart';

class HistoryTotal extends StatefulWidget {
  final UserProvider userProvider;
  final WorkProvider workProvider;
  final List<DateTime> days;

  HistoryTotal({
    @required this.userProvider,
    @required this.workProvider,
    @required this.days,
  });

  @override
  _HistoryTotalState createState() => _HistoryTotalState();
}

class _HistoryTotalState extends State<HistoryTotal> {
  int workCount = 0;
  String workTime = '';

  void _init() async {
    await widget.workProvider
        .selectList(
            groupId: widget.userProvider.group?.id,
            userId: widget.userProvider.user?.id,
            startAt: widget.days.first,
            endAt: widget.days.last)
        .then((value) {
      Map _count = {};
      String _workTime = '00:00';
      for (WorkModel _work in value) {
        _count['${DateFormat(formatY_M_D).format(_work.startedAt)}'] = '';
        _workTime = addTime(_workTime, _work.workTime());
      }
      setState(() {
        workCount = _count.length;
        workTime = _workTime;
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
          '${DateFormat(formatYM).format(widget.days.first)}の集計',
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
            title: '会社/組織',
            time: widget.userProvider.group?.name,
          ),
          CustomHistoryDetailsListTile(
            icon: null,
            title: '勤務日数',
            time: '$workCount 日',
          ),
          CustomHistoryDetailsListTile(
            icon: null,
            title: '勤務時間',
            time: '$workTime',
          ),
          CustomHistoryDetailsListTile(
            icon: null,
            title: '法定内時間',
            time: '00:00',
          ),
          CustomHistoryDetailsListTile(
            icon: null,
            title: '法定外時間',
            time: '00:00',
          ),
          CustomHistoryDetailsListTile(
            icon: null,
            title: '深夜時間',
            time: '00:00',
          ),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }
}
