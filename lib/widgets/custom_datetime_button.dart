import 'package:flutter/material.dart';

class CustomDatetimeButton extends StatelessWidget {
  final String labelText;
  final Function onTap;

  CustomDatetimeButton({
    this.labelText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ListTile(
          title: Text(labelText),
          trailing: Icon(Icons.arrow_drop_down),
        ),
      ),
    );
  }
}
