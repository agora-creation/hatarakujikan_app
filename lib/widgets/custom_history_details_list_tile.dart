import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';

class CustomHistoryDetailsListTile extends StatelessWidget {
  final Icon icon;
  final String label;
  final String time;

  CustomHistoryDetailsListTile({
    this.icon,
    this.label,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        leading: icon,
        title: Text(label),
        trailing: Text(time),
      ),
    );
  }
}
