import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';

class CustomApplyListTile extends StatelessWidget {
  final String chipText;
  final Color chipColor;
  final String dateText;
  final Function onTap;

  CustomApplyListTile({
    this.chipText,
    this.chipColor,
    this.dateText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        leading: Chip(
          backgroundColor: chipColor,
          label: Text(
            chipText,
            style: TextStyle(color: Colors.black87),
          ),
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
              dateText,
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
