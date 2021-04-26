import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/navigation.dart';
import 'package:hatarakujikan_app/screens/notice_details.dart';
import 'package:hatarakujikan_app/widgets/custom_notice_list_tile.dart';

class NoticeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('お知らせ'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: 5,
        itemBuilder: (_, index) {
          return CustomNoticeListTile(
            onTap: () => nextScreen(context, NoticeDetailsScreen()),
          );
        },
      ),
    );
  }
}
