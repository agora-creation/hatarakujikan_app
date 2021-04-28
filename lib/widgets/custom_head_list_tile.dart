import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';

class CustomHeadListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        leading: Text('日付'),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '出勤時間',
              style: TextStyle(color: Colors.black54, fontSize: 14.0),
            ),
            Text(
              '退勤時間',
              style: TextStyle(color: Colors.black54, fontSize: 14.0),
            ),
            Text(
              '勤務時間',
              style: TextStyle(color: Colors.black54, fontSize: 14.0),
            ),
          ],
        ),
        trailing: Text(''),
      ),
    );
  }
}
