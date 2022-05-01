import 'package:flutter/material.dart';

class ErrorList extends StatelessWidget {
  final String? label;

  ErrorList(this.label);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.redAccent,
      title: Text(
        label ?? '',
        style: TextStyle(color: Colors.white, fontSize: 14.0),
      ),
    );
  }
}
