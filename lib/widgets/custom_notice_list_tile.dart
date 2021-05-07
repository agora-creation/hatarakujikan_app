import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/user_notice.dart';
import 'package:intl/intl.dart';

class CustomNoticeListTile extends StatelessWidget {
  final UserNoticeModel notice;
  final Function onTap;

  CustomNoticeListTile({
    this.notice,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        leading: notice.read
            ? Text('既読')
            : Text(
                '未読',
                style: TextStyle(color: Colors.red),
              ),
        title: Text(notice.title),
        subtitle: Text('${DateFormat('yyyy/MM/dd').format(notice.createdAt)}'),
        trailing: Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
