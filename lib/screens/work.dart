import 'package:flutter/material.dart';

class WorkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      children: [
        Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blueAccent, width: 3.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('2021/03/12(金)'),
              Text(
                '18:30',
                style: TextStyle(fontSize: 40.0),
              ),
              Text('出勤中'),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        TextButton(
          onPressed: () {},
          child: Text('出勤'),
        ),
      ],
    );
  }
}
