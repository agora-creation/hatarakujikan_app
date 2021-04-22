import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  final List<Widget> buttons;

  ErrorMessage({
    this.message,
    this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: buttons,
          ),
        ],
      ),
    );
  }
}
