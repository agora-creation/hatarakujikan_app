import 'package:flutter/material.dart';

class GroupButton extends StatelessWidget {
  final Function createOnPressed;
  final Function inOnPressed;

  GroupButton({
    @required this.createOnPressed,
    @required this.inOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFEFFFA),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: createOnPressed,
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
          Expanded(
            child: TextButton(
              onPressed: inOnPressed,
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
                  side: BorderSide(color: Colors.blue, width: 1),
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
