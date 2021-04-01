import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';

class CustomHistoryListTile extends StatelessWidget {
  final String day;
  final String started;
  final String ended;
  final String work;

  CustomHistoryListTile({
    this.day,
    this.started,
    this.ended,
    this.work,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        leading: Text(day),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '出勤',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                ),
                Text(started),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '退勤',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                ),
                Text(ended),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '勤務',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                ),
                Text(work),
              ],
            ),
          ],
        ),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}
