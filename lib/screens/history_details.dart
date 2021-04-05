import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryDetailsScreen extends StatelessWidget {
  final DateTime day;

  HistoryDetailsScreen({@required this.day});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5F5),
        elevation: 0.0,
        centerTitle: true,
        title: Text('${DateFormat('yyyy年MM月dd日 (E)', 'ja').format(day)}'),
      ),
      body: Container(),
    );
  }
}
