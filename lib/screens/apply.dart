import 'package:flutter/material.dart';

class ApplyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      children: [
        Text('年月選択'),
        SizedBox(height: 8.0),
        Divider(height: 1.0, color: Colors.grey),
      ],
    );
  }
}
