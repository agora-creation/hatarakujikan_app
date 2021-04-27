import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/screens/group_button.dart';

class GroupScreen extends StatefulWidget {
  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text('会社/組織に所属しておりません'),
          ),
        ),
        GroupButton(),
      ],
    );
  }
}
