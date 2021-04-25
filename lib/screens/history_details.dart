import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/user_work.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';
import 'package:hatarakujikan_app/widgets/round_border_button.dart';
import 'package:intl/intl.dart';

class HistoryDetailsScreen extends StatelessWidget {
  final DateTime day;
  final List<UserWorkModel> dayWorks;

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
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          Text('出勤時間'),
          Text('退勤時間'),
          SizedBox(height: 16.0),
          RoundBackgroundButton(
            labelText: '打刻修正申請',
            labelColor: Colors.white,
            backgroundColor: Colors.blue,
            labelFontSize: 16.0,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            onPressed: () {},
          ),
          SizedBox(height: 8.0),
          RoundBorderButton(
            labelText: '休暇申請',
            labelColor: Colors.orange,
            borderColor: Colors.orange,
            labelFontSize: 16.0,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            onPressed: () {},
          ),
          SizedBox(height: 8.0),
          RoundBorderButton(
            labelText: '残業申請',
            labelColor: Colors.red,
            borderColor: Colors.red,
            labelFontSize: 16.0,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            onPressed: () {},
          ),
          SizedBox(height: 8.0),
          RoundBackgroundButton(
            labelText: '削除申請',
            labelColor: Colors.white,
            backgroundColor: Colors.red,
            labelFontSize: 16.0,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
