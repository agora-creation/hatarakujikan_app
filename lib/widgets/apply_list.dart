import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';

class ApplyList extends StatelessWidget {
  final String? chipText;
  final Color? chipColor;
  final String? dateTime;
  final Function()? onTap;

  ApplyList({
    this.chipText,
    this.chipColor,
    this.dateTime,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        leading: Chip(
          label: Text(chipText ?? '', style: TextStyle(color: Colors.black87)),
          backgroundColor: chipColor,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '申請日',
              style: TextStyle(color: Colors.black54, fontSize: 12.0),
            ),
            Text(
              dateTime ?? '',
              style: TextStyle(color: Colors.black87, fontSize: 16.0),
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
