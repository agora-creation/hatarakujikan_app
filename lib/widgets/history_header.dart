import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';

class HistoryHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        leading: Text(
          '日付',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14.0,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '勤務状況',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14.0,
              ),
            ),
            Text(
              '出勤時間',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14.0,
              ),
            ),
            Text(
              '退勤時間',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14.0,
              ),
            ),
            Text(
              '勤務時間',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
