import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';

class CustomListTile extends StatelessWidget {
  final Icon? icon;
  final String? label;
  final String? value;

  CustomListTile({
    this.icon,
    this.label,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        leading: icon,
        title: Text(label ?? ''),
        trailing: Text(value ?? ''),
      ),
    );
  }
}
