import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';

class SettingList extends StatelessWidget {
  final IconData? iconData;
  final String? label;
  final Function()? onTap;

  SettingList({
    this.iconData,
    this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        leading: Icon(iconData),
        title: Text(label ?? ''),
        trailing: Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
