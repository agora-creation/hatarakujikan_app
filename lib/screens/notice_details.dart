import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/user_notice.dart';
import 'package:hatarakujikan_app/providers/user_notice.dart';
import 'package:intl/intl.dart';

class NoticeDetailsScreen extends StatefulWidget {
  final UserNoticeProvider userNoticeProvider;
  final UserNoticeModel notice;

  NoticeDetailsScreen({
    @required this.userNoticeProvider,
    @required this.notice,
  });

  @override
  _NoticeDetailsScreenState createState() => _NoticeDetailsScreenState();
}

class _NoticeDetailsScreenState extends State<NoticeDetailsScreen> {
  @override
  void initState() {
    super.initState();
    if (!widget.notice.read) {
      widget.userNoticeProvider.updateRead(notice: widget.notice);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('お知らせの詳細'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left, size: 32.0),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          Text(
            widget.notice.title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(widget.notice.message),
          SizedBox(height: 8.0),
          Divider(),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              '${DateFormat('yyyy/MM/dd HH:mm').format(widget.notice.createdAt)}',
            ),
          ),
        ],
      ),
    );
  }
}
