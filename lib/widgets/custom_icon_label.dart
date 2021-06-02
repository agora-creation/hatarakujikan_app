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
            SizedBox(width: 8.0),
            Text(labelText),
          ],
        ),
        SizedBox(height: 8.0),
        Divider(height: 1.0, color: Colors.grey),
      ],
    );
  }
}
