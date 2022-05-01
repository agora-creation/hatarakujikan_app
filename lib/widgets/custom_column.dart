import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';

class CustomColumn extends StatelessWidget {
  final String? label;
  final String? value;

  CustomColumn({
    this.label,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: kBottomBorderDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label ?? '', style: TextStyle(fontSize: 14.0)),
          Text(value ?? '',
              style: TextStyle(color: Colors.black87, fontSize: 18.0)),
        ],
      ),
    );
  }
}
