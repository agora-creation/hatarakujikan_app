import 'package:flutter/material.dart';

class RoundBackgroundButton extends StatelessWidget {
  final String labelText;
  final Color labelColor;
  final Color backgroundColor;
  final double labelFontSize;
  final EdgeInsetsGeometry padding;
  final Function onPressed;

  RoundBackgroundButton({
    this.labelText,
    this.labelColor,
    this.backgroundColor,
    this.labelFontSize,
    this.padding,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          labelText,
          style: TextStyle(
            color: labelColor,
            fontSize: labelFontSize,
          ),
        ),
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: StadiumBorder(),
          padding: padding,
        ),
      ),
    );
  }
}
