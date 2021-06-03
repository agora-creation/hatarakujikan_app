import 'package:flutter/material.dart';

class CustomDateButton extends StatelessWidget {
  final String labelText;
  final Function onTap;

  CustomDateButton({
    this.labelText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.today, color: Colors.black54),
            Text(labelText, style: TextStyle(color: Colors.black87)),
            Icon(Icons.arrow_drop_down, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
