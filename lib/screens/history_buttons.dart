import 'package:flutter/material.dart';

class HistoryButtons extends StatelessWidget {
  final String? month;
  final Function()? monthOnPressed;
  final Function()? totalOnPressed;

  HistoryButtons({
    this.month,
    this.monthOnPressed,
    this.totalOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFEFFFA),
      child: Row(
        children: [
          Expanded(
            child: TextButton.icon(
              onPressed: monthOnPressed,
              icon: Icon(Icons.today, color: Color(0xFFFEFFFA)),
              label: Text(
                month ?? '',
                style: TextStyle(
                  color: Color(0xFFFEFFFA),
                  fontSize: 16.0,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                padding: EdgeInsets.all(16.0),
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              onPressed: totalOnPressed,
              icon: Icon(Icons.view_list, color: Color(0xFFFEFFFA)),
              label: Text(
                '集計',
                style: TextStyle(
                  color: Color(0xFFFEFFFA),
                  fontSize: 16.0,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                padding: EdgeInsets.all(16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
