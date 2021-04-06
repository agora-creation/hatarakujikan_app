import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TotalScreen extends StatelessWidget {
  final DateTime month;

  TotalScreen({@required this.month});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0.0,
        centerTitle: true,
        leading: Container(),
        title: Text(
          '${DateFormat('yyyy年MM月').format(month)}の合計時間',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [],
      ),
    );
  }
}
