import 'package:flutter/material.dart';

class ExpandedButton extends StatelessWidget {
  final Color? backgroundColor;
  final String? label;
  final Color? color;
  final Icon? leading;
  final Icon? trailing;
  final Function()? onTap;

  ExpandedButton({
    this.backgroundColor,
    this.label,
    this.color,
    this.leading,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: ListTile(
        leading: leading,
        title: Text(
          label ?? '',
          style: TextStyle(color: color),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
