import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';

class ApplyList2 extends StatelessWidget {
  final String? label;
  final String? subLabel;
  final Function()? onTap;

  ApplyList2({
    this.label,
    this.subLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        title: Text(label ?? ''),
        subtitle: subLabel != null
            ? Text(
                subLabel ?? '',
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            : null,
        trailing: onTap != null ? Icon(Icons.chevron_right) : null,
        onTap: onTap,
      ),
    );
  }
}
