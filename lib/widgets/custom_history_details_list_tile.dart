import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';

class CustomHistoryDetailsListTile extends StatelessWidget {
  final Icon icon;
  final String title;
  final String time;
  final Function onTap;

  CustomHistoryDetailsListTile({
    this.icon,
    this.title,
    this.time,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        leading: icon,
        title: Text(title),
        trailing: Text(time),
        onTap: onTap,
      ),
    );
  }
}
