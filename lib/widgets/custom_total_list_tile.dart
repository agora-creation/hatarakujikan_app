import 'package:flutter/material.dart';

class CustomTotalListTile extends StatelessWidget {
  final String title;
  final Function onTap;

  CustomTotalListTile({
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          boxShadow: [
            BoxShadow(
              color: Colors.black87,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          trailing: Icon(
            Icons.arrow_drop_up,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
