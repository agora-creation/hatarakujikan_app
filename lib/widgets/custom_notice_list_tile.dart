import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';

class CustomNoticeListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        leading: Text('既読'),
        title: Text('新しいメッセージがあります'),
        subtitle: Text('2021/03/30'),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}
