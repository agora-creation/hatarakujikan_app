import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/user_notice.dart';

class NoticeList extends StatelessWidget {
  final UserNoticeModel? notice;
  final Function()? onTap;

  NoticeList({
    this.notice,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        leading: notice?.read == true
            ? Text('既読')
            : Text(
                '未読',
                style: TextStyle(color: Colors.red),
              ),
        title: Text(
          notice?.title ?? '',
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(dateText('yyyy/MM/dd', notice?.createdAt)),
        trailing: Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
