import 'package:flutter/material.dart';

class RoundBackgroundButton extends StatelessWidget {
  final String labelText;
  final Color labelColor;
  final Color backgroundColor;
  final Function onPressed;

  RoundBackgroundButton({
    this.labelText,
    this.labelColor,
    this.backgroundColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FlatButton(
        padding: EdgeInsets.all(16.0),
        shape: StadiumBorder(),
        color: backgroundColor,
        onPressed: onPressed,
        child: Text(
          labelText,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: labelColor,
          ),
        ),
      ),
    );
  }
}
