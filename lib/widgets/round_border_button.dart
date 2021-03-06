import 'package:flutter/material.dart';

class RoundBorderButton extends StatelessWidget {
  final String labelText;
  final Color labelColor;
  final Color borderColor;
  final Function onPressed;

  RoundBorderButton({
    this.labelText,
    this.labelColor,
    this.borderColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FlatButton(
        padding: EdgeInsets.all(16.0),
        shape: StadiumBorder(side: BorderSide(color: borderColor)),
        color: Colors.white,
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
