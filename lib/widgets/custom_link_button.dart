import 'package:flutter/material.dart';

class CustomLinkButton extends StatelessWidget {
  final String labelText;
  final Color labelColor;
  final Function onTap;

  CustomLinkButton({
    this.labelText,
    this.labelColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        labelText,
        style: TextStyle(
          color: labelColor,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
