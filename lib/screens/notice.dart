import 'package:flutter/material.dart';

class NoticeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        leading: Container(),
        title: Text('お知らせ'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        children: [
          Text('お知らせ一覧'),
          SizedBox(height: 8.0),
          Divider(height: 1.0, color: Colors.grey),
        ],
      ),
    );
  }
}
