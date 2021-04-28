import 'package:flutter/material.dart';

class CustomExpandedButton extends StatelessWidget {
  final Color buttonColor;
  final String labelText;
  final Color labelColor;
  final Icon leadingIcon;
  final Icon trailingIcon;
  final Function onTap;

  CustomExpandedButton({
    this.buttonColor,
    this.labelText,
    this.labelColor,
    this.leadingIcon,
    this.trailingIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: buttonColor,
      child: ListTile(
        leading: leadingIcon,
        title: Text(labelText, style: TextStyle(color: labelColor)),
        trailing: trailingIcon,
        onTap: onTap,
      ),
    );
  }
}
