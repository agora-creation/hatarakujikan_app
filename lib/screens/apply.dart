import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/widgets/custom_month_list_tile.dart';
import 'package:intl/intl.dart';

class ApplyScreen extends StatefulWidget {
  @override
  _ApplyScreenState createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  DateTime selectMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomMonthListTile(
          month: '${DateFormat('yyyy年MM月').format(selectMonth)}',
          onTap: () {},
        ),
        Expanded(
          child: Center(
            child: Text('申請'),
          ),
        ),
      ],
    );
  }
}
