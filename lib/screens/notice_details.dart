import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/user_notice.dart';
import 'package:hatarakujikan_app/providers/user_notice.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';

class NoticeDetailsScreen extends StatefulWidget {
  final UserNoticeProvider userNoticeProvider;
  final UserNoticeModel notice;

  NoticeDetailsScreen({
    required this.userNoticeProvider,
    required this.notice,
  });

  @override
  _NoticeDetailsScreenState createState() => _NoticeDetailsScreenState();
}

class _NoticeDetailsScreenState extends State<NoticeDetailsScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.notice.read == false) {
      widget.userNoticeProvider.update(
        id: widget.notice.id,
        userId: widget.notice.userId,
      );
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
          icon: Icon(Icons.chevron_left, size: 32.0),
          onPressed: () => Navigator.pop(context),
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
              dateText('yyyy/MM/dd HH:mm', widget.notice.createdAt),
            ),
          ),
          SizedBox(height: 16.0),
          RoundBackgroundButton(
            label: 'このお知らせを削除する',
            color: Colors.white,
            backgroundColor: Colors.red,
            onPressed: () {
              widget.userNoticeProvider.delete(
                id: widget.notice.id,
                userId: widget.notice.userId,
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
