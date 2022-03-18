import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:intl/intl.dart';

class CustomApplyListTile extends StatelessWidget {
  final String? state;
  final DateTime? dateTime;
  final Function()? onTap;

  CustomApplyListTile({
    this.state,
    this.dateTime,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        leading: Chip(
          backgroundColor: Colors.blue.shade100,
          label: Text(state!, style: TextStyle(color: Colors.black87)),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '申請日',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12.0,
              ),
            ),
            Text(
              '${DateFormat('yyyy/MM/dd').format(dateTime!)}',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        trailing: Icon(Icons.chevron_right),
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        onTap: onTap,
      ),
    );
  }
}
