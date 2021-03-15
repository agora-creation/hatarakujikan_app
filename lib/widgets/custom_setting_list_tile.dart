import 'package:flutter/material.dart';

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
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: Colors.grey.shade300,
            ),
          ),
        ),
        child: ListTile(
          leading: Icon(iconData),
          title: Text(title),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
