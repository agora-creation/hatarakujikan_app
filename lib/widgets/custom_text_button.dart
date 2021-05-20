import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String labelText;
  final Color backgroundColor;
  final Function onPressed;

  CustomTextButton({
    this.labelText,
    this.backgroundColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        labelText,
        style: TextStyle(color: Colors.white),
      ),
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
      ),
    );
  }
}
