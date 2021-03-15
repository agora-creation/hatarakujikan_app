import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';

class CustomSettingListTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function onTap;

  CustomSettingListTile({
    this.iconData,
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: kBottomBorderDecoration,
        child: ListTile(
          leading: Icon(iconData),
          title: Text(title),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
