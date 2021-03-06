import 'package:flutter/material.dart';

class WorkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (_, index) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey.shade300),
            ),
          ),
          child: ListTile(
            title: Row(
              children: [
                Text('出: 2021/03/05 11:20'),
                SizedBox(width: 16.0),
                Text('退: 2021/03/05 11:20'),
              ],
            ),
          ),
        );
      },
    );
  }
}
