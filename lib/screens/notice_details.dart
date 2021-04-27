import 'package:flutter/material.dart';

class NoticeDetailsScreen extends StatefulWidget {
  @override
  _NoticeDetailsScreenState createState() => _NoticeDetailsScreenState();
}

class _NoticeDetailsScreenState extends State<NoticeDetailsScreen> {
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
            '新しいメッセージがあります',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text('メッセージ内容はここに表示されます。PUSH通知はONを推奨します。'),
          SizedBox(height: 8.0),
          Divider(),
          Align(
            alignment: Alignment.bottomRight,
            child: Text('2021/03/21 00:00 (システム管理者)'),
          ),
        ],
      ),
    );
  }
}
