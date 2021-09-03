import 'package:flutter/material.dart';

class ErrorListTile extends StatelessWidget {
  final String label;

  ErrorListTile({this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.redAccent,
      title: Text(
        label,
        style: TextStyle(color: Colors.white, fontSize: 14.0),
      ),
    );
  }
}
