import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/widgets/custom_notice_list_tile.dart';

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
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          Text('お知らせ一覧'),
          SizedBox(height: 8.0),
          Divider(height: 1.0, color: Colors.grey),
          ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: 5,
            itemBuilder: (_, index) {
              return CustomNoticeListTile();
            },
          ),
        ],
      ),
    );
  }
}
