import 'package:flutter/material.dart';

class CustomMonthListTile extends StatelessWidget {
  final String month;
  final Function onTap;

  CustomMonthListTile({
    this.month,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.black87,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(
            Icons.calendar_today,
            color: Colors.white,
          ),
          title: Text(
            month,
            style: TextStyle(color: Colors.white),
          ),
          trailing: Icon(
            Icons.find_replace,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
