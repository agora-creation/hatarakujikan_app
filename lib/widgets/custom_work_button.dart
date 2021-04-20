import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/user_work.dart';

class CustomWorkButton extends StatelessWidget {
  final UserProvider userProvider;
  final UserWorkProvider userWorkProvider;
  final double latitude;
  final double longitude;

  CustomWorkButton({
    this.userProvider,
    this.userWorkProvider,
    this.latitude,
    this.longitude,
  });

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
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: userProvider.user?.workLv == 0
                    ? TextButton(
                        onPressed: () {},
                        child: Text(
                          '出勤',
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
                      )
                    : TextButton(
                        onPressed: null,
                        child: Text(
                          '出勤',
                          style: TextStyle(
                            color: Color(0xFFFEFFFA),
                            fontSize: 16.0,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          padding: EdgeInsets.all(16.0),
                        ),
                      ),
              ),
              SizedBox(width: 1.0),
              Expanded(
                child: userProvider.user?.workLv == 1
                    ? TextButton(
                        onPressed: () {},
                        child: Text(
                          '退勤',
                          style: TextStyle(
                            color: Color(0xFFFEFFFA),
                            fontSize: 16.0,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          padding: EdgeInsets.all(16.0),
                        ),
                      )
                    : TextButton(
                        onPressed: () {},
                        child: Text(
                          '退勤',
                          style: TextStyle(
                            color: Color(0xFFFEFFFA),
                            fontSize: 16.0,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          padding: EdgeInsets.all(16.0),
                        ),
                      ),
              ),
            ],
          ),
          SizedBox(height: 1.0),
          Row(
            children: [
              Expanded(
                child: userProvider.user?.workLv == 1
                    ? TextButton(
                        onPressed: () {},
                        child: Text(
                          '休憩開始',
                          style: TextStyle(
                            color: Color(0xFFFEFFFA),
                            fontSize: 16.0,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          padding: EdgeInsets.all(16.0),
                        ),
                      )
                    : TextButton(
                        onPressed: null,
                        child: Text(
                          '休憩開始',
                          style: TextStyle(
                            color: Color(0xFFFEFFFA),
                            fontSize: 16.0,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          padding: EdgeInsets.all(16.0),
                        ),
                      ),
              ),
              SizedBox(width: 1.0),
              Expanded(
                child: userProvider.user?.workLv == 2
                    ? TextButton(
                        onPressed: () {},
                        child: Text(
                          '休憩終了',
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 16.0,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          side: BorderSide(color: Colors.orange, width: 1),
                          backgroundColor: Color(0xFFFEFFFA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          padding: EdgeInsets.all(16.0),
                        ),
                      )
                    : TextButton(
                        onPressed: null,
                        child: Text(
                          '休憩終了',
                          style: TextStyle(
                            color: Color(0xFFFEFFFA),
                            fontSize: 16.0,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          padding: EdgeInsets.all(16.0),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
