import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/widgets/custom_text_button.dart';

class ErrorDialog extends StatelessWidget {
  final String message;

  ErrorDialog(this.message);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Icon(
              Icons.report_problem,
              color: Colors.red,
              size: 40.0,
            ),
          ),
          SizedBox(height: 16.0),
          Text(message),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextButton(
                onPressed: () => Navigator.pop(context),
                label: 'キャンセル',
                color: Colors.grey,
              ),
              CustomTextButton(
                onPressed: () => Navigator.pop(context),
                label: 'はい',
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
