import 'package:flutter/material.dart';

class CustomIconLabel extends StatelessWidget {
  final Icon icon;
  final String label;

  CustomIconLabel({
    this.icon,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            icon,
            SizedBox(width: 4.0),
            Text(label),
          ],
        ),
      ],
    );
  }
}
