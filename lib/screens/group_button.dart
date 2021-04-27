import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/navigation.dart';
import 'package:hatarakujikan_app/screens/group_create.dart';

class GroupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFEFFFA),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () => overlayScreen(context, GroupCreateScreen()),
              child: Text(
                '会社/組織を作る',
                style: TextStyle(
                  color: Color(0xFFFEFFFA),
                  fontSize: 16.0,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                padding: EdgeInsets.all(16.0),
              ),
            ),
          ),
          SizedBox(width: 1.0),
          Expanded(
            child: TextButton(
              onPressed: null,
              child: Text(
                '会社/組織に入る',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16.0,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFFFEFFFA),
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
