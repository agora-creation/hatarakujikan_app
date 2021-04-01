import 'package:flutter/material.dart';

class CustomTotalButton extends StatelessWidget {
  final String title;
  final Function onTap;

  CustomTotalButton({
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal,
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
