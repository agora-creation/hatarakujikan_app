import 'package:flutter/material.dart';

class CustomWorkArea extends StatelessWidget {
  final Widget topLeft;
  final Widget topRight;
  final Widget bottomLeft;
  final Widget bottomRight;

  CustomWorkArea({
    this.topLeft,
    this.topRight,
    this.bottomLeft,
    this.bottomRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          title: Column(
            children: [
              Row(
                children: [
                  Expanded(child: topLeft),
                  SizedBox(width: 8.0),
                  Expanded(child: topRight),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(child: bottomLeft),
                  SizedBox(width: 8.0),
                  Expanded(child: bottomRight),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
