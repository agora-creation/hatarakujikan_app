import 'package:flutter/material.dart';

class CustomLocationButton extends StatelessWidget {
  final String location;
  final Function onTap;

  CustomLocationButton({
    this.location,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          boxShadow: [
            BoxShadow(
              color: Colors.black87,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(
            Icons.location_pin,
            color: Colors.white,
          ),
          title: Text(
            location,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
