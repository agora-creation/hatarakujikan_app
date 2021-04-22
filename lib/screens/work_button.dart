import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/user_work.dart';

class WorkButton extends StatelessWidget {
  final UserProvider userProvider;
  final UserWorkProvider userWorkProvider;
  final List<double> locations;

  WorkButton({
    @required this.userProvider,
    @required this.userWorkProvider,
    @required this.locations,
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
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) => WorkDialog(),
                          );
                        },
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

class WorkDialog extends StatefulWidget {
  @override
  _WorkDialogState createState() => _WorkDialogState();
}

class _WorkDialogState extends State<WorkDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.timer,
                color: Colors.blue,
                size: 40.0,
              ),
              SizedBox(width: 8.0),
              Icon(
                Icons.arrow_right_alt,
                color: Colors.blue,
                size: 40.0,
              ),
              SizedBox(width: 8.0),
              Icon(
                Icons.list_alt,
                color: Colors.blue,
                size: 40.0,
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Text('出勤時間を記録します。よろしいですか？'),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('キャンセル', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(backgroundColor: Colors.grey),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('はい', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
