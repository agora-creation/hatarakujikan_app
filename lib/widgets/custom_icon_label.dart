import 'package:flutter/material.dart';

class CustomIconLabel extends StatelessWidget {
  final Icon icon;
  final String labelText;

  CustomIconLabel({
    this.icon,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            icon,
            SizedBox(width: 4.0),
            Text(labelText),
          ],
        ),
      ],
    );
  }
}
