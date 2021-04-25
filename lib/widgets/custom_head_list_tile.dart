import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';

class CustomHeadListTile extends StatelessWidget {
  final List<Widget> children;

  CustomHeadListTile({this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        leading: Text('日付'),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: children,
        ),
        trailing: Text(''),
      ),
    );
  }
}
