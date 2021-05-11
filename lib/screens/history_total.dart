import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          '集計',
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
          SizedBox(height: 16.0),
          CustomHistoryDetailsListTile(
            icon: null,
            title: '対象会社/組織',
            time: widget.userProvider.group?.name,
          ),
          CustomHistoryDetailsListTile(
            icon: null,
            title: '対象年月',
            time: '${DateFormat('yyyy年MM月').format(widget.days.first)}',
          ),
          CustomHistoryDetailsListTile(
            icon: null,
            title: '勤務日数',
            time: '0 日',
          ),
          CustomHistoryDetailsListTile(
            icon: null,
            title: '勤務時間',
            time: '00:00',
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
        ],
      ),
    );
  }
}
