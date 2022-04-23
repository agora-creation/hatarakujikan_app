import 'package:flutter/material.dart';

class WorkButton extends StatelessWidget {
  final String? label;
  final Color? color;
  final Color? backgroundColor;
  final Color? borderColor;
  final Function()? onPressed;

  WorkButton({
    this.label,
    this.color,
    this.backgroundColor,
    this.borderColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label ?? '',
          style: TextStyle(
            color: color,
            fontSize: 16.0,
          ),
        ),
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          side: borderColor != null
              ? BorderSide(color: borderColor ?? Color(0xFF000000))
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          padding: EdgeInsets.all(16.0),
        ),
      ),
    );
  }
}
