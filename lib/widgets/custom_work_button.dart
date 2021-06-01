import 'package:flutter/material.dart';

class CustomWorkButton extends StatelessWidget {
  final String labelText;
  final Color labelColor;
  final Color backgroundColor;
  final Color borderColor;
  final Function onPressed;

  CustomWorkButton({
    this.labelText,
    this.labelColor,
    this.backgroundColor,
    this.borderColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        labelText,
        style: TextStyle(
          color: labelColor,
          fontSize: 16.0,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        side: borderColor != null
            ? BorderSide(color: borderColor, width: 1)
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        padding: EdgeInsets.all(16.0),
      ),
    );
  }
}
