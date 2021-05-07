import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/widgets/custom_history_details_list_tile.dart';
import 'package:intl/intl.dart';

class HistoryDetailsScreen extends StatelessWidget {
  final DateTime day;
  final List<WorkModel> dayWorks;

  HistoryDetailsScreen({
    @required this.day,
    @required this.dayWorks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('${DateFormat('yyyy年MM月dd日 (E)', 'ja').format(day)}'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left, size: 32.0, color: Colors.black54),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          Text('記録した時間'),
          SizedBox(height: 8.0),
          Divider(height: 1.0, color: Colors.grey),
          dayWorks.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: dayWorks.length,
                  itemBuilder: (_, index) {
                    WorkModel _work = dayWorks[index];
                    return Column(
                      children: [
                        CustomHistoryDetailsListTile(
                          icon: Icon(Icons.run_circle, color: Colors.blue),
                          title: '出勤時間',
                          time:
                              '${DateFormat('HH:mm').format(_work.startedAt)}',
                          onTap: null,
                        ),
                        CustomHistoryDetailsListTile(
                          icon: Icon(Icons.run_circle, color: Colors.orange),
                          title: '休憩開始時間',
                          time: '--:--',
                          onTap: null,
                        ),
                        CustomHistoryDetailsListTile(
                          icon: Icon(Icons.run_circle_outlined,
                              color: Colors.orange),
                          title: '休憩終了時間',
                          time: '--:--',
                          onTap: null,
                        ),
                        CustomHistoryDetailsListTile(
                          icon: Icon(Icons.run_circle, color: Colors.red),
                          title: '退勤時間',
                          time: '${DateFormat('HH:mm').format(_work.endedAt)}',
                          onTap: null,
                        ),
                        CustomHistoryDetailsListTile(
                          icon: null,
                          title: '勤務時間',
                          time: '${_work.workTime}',
                          onTap: null,
                        ),
                      ],
                    );
                  },
                )
              : Column(
                  children: [
                    CustomHistoryDetailsListTile(
                      icon: Icon(Icons.run_circle, color: Colors.blue),
                      title: '出勤時間',
                      time: '--:--',
                      onTap: null,
                    ),
                    CustomHistoryDetailsListTile(
                      icon: Icon(Icons.run_circle, color: Colors.orange),
                      title: '休憩開始時間',
                      time: '--:--',
                      onTap: null,
                    ),
                    CustomHistoryDetailsListTile(
                      icon:
                          Icon(Icons.run_circle_outlined, color: Colors.orange),
                      title: '休憩終了時間',
                      time: '--:--',
                      onTap: null,
                    ),
                    CustomHistoryDetailsListTile(
                      icon: Icon(Icons.run_circle, color: Colors.red),
                      title: '退勤時間',
                      time: '--:--',
                      onTap: null,
                    ),
                    CustomHistoryDetailsListTile(
                      icon: null,
                      title: '勤務時間',
                      time: '--:--',
                      onTap: null,
                    ),
                  ],
                ),
          SizedBox(height: 16.0),
          Text('記録した場所'),
          SizedBox(height: 8.0),
          Divider(height: 1.0, color: Colors.grey),
        ],
      ),
    );
  }
}
