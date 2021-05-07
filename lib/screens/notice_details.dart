import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/user_notice.dart';
import 'package:hatarakujikan_app/providers/user_notice.dart';
import 'package:intl/intl.dart';

class NoticeDetailsScreen extends StatefulWidget {
  final UserNoticeModel notice;
  final UserNoticeProvider userNoticeProvider;

  NoticeDetailsScreen({
    @required this.notice,
    @required this.userNoticeProvider,
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
        backgroundColor: Colors.grey,
        elevation: 0.0,
        centerTitle: true,
        title: Text('お知らせの詳細', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left, size: 32.0, color: Colors.white),
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
                '${DateFormat('yyyy/MM/dd HH:mm').format(widget.notice.createdAt)}'),
          ),
        ],
      ),
    );
  }
}
