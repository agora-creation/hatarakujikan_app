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
                child: locations != null && userProvider.user?.workLv == 0
                    ? TextButton(
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) => WorkStartDialog(
                              userProvider: userProvider,
                              userWorkProvider: userWorkProvider,
                              locations: locations,
                            ),
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
                child: locations != null && userProvider.user?.workLv == 1
                    ? TextButton(
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) => WorkEndDialog(
                              userProvider: userProvider,
                              userWorkProvider: userWorkProvider,
                              locations: locations,
                            ),
                          );
                        },
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
                        onPressed: null,
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
                child: locations != null && userProvider.user?.workLv == 1
                    ? TextButton(
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) => BreakStartDialog(
                              userProvider: userProvider,
                              userWorkProvider: userWorkProvider,
                              locations: locations,
                            ),
                          );
                        },
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
                child: locations != null && userProvider.user?.workLv == 2
                    ? TextButton(
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) => BreakEndDialog(
                              userProvider: userProvider,
                              userWorkProvider: userWorkProvider,
                              locations: locations,
                            ),
                          );
                        },
                        child: Text(
                          '休憩終了',
                          style: TextStyle(
                            color: Colors.orange,
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

class WorkStartDialog extends StatefulWidget {
  final UserProvider userProvider;
  final UserWorkProvider userWorkProvider;
  final List<double> locations;

  WorkStartDialog({
    @required this.userProvider,
    @required this.userWorkProvider,
    @required this.locations,
  });

  @override
  _WorkStartDialogState createState() => _WorkStartDialogState();
}

class _WorkStartDialogState extends State<WorkStartDialog> {
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
                onPressed: () async {
                  if (!await widget.userWorkProvider.workStart(
                    user: widget.userProvider.user,
                    locations: widget.locations,
                  )) {
                    return;
                  }
                  widget.userProvider.reloadUserModel();
                  Navigator.pop(context);
                },
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

class WorkEndDialog extends StatefulWidget {
  final UserProvider userProvider;
  final UserWorkProvider userWorkProvider;
  final List<double> locations;

  WorkEndDialog({
    @required this.userProvider,
    @required this.userWorkProvider,
    @required this.locations,
  });

  @override
  _WorkEndDialogState createState() => _WorkEndDialogState();
}

class _WorkEndDialogState extends State<WorkEndDialog> {
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
                color: Colors.red,
                size: 40.0,
              ),
              SizedBox(width: 8.0),
              Icon(
                Icons.arrow_right_alt,
                color: Colors.red,
                size: 40.0,
              ),
              SizedBox(width: 8.0),
              Icon(
                Icons.list_alt,
                color: Colors.red,
                size: 40.0,
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Text('退勤時間を記録します。よろしいですか？'),
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
                onPressed: () async {
                  if (!await widget.userWorkProvider.workEnd(
                    user: widget.userProvider.user,
                    locations: widget.locations,
                  )) {
                    return;
                  }
                  widget.userProvider.reloadUserModel();
                  Navigator.pop(context);
                },
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

class BreakStartDialog extends StatefulWidget {
  final UserProvider userProvider;
  final UserWorkProvider userWorkProvider;
  final List<double> locations;

  BreakStartDialog({
    @required this.userProvider,
    @required this.userWorkProvider,
    @required this.locations,
  });

  @override
  _BreakStartDialogState createState() => _BreakStartDialogState();
}

class _BreakStartDialogState extends State<BreakStartDialog> {
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
                color: Colors.orange,
                size: 40.0,
              ),
              SizedBox(width: 8.0),
              Icon(
                Icons.arrow_right_alt,
                color: Colors.orange,
                size: 40.0,
              ),
              SizedBox(width: 8.0),
              Icon(
                Icons.list_alt,
                color: Colors.orange,
                size: 40.0,
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Text('休憩開始時間を記録します。よろしいですか？'),
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
                onPressed: () async {
                  if (!await widget.userWorkProvider.breakStart(
                    user: widget.userProvider.user,
                    locations: widget.locations,
                  )) {
                    return;
                  }
                  widget.userProvider.reloadUserModel();
                  Navigator.pop(context);
                },
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

class BreakEndDialog extends StatefulWidget {
  final UserProvider userProvider;
  final UserWorkProvider userWorkProvider;
  final List<double> locations;

  BreakEndDialog({
    @required this.userProvider,
    @required this.userWorkProvider,
    @required this.locations,
  });

  @override
  _BreakEndDialogState createState() => _BreakEndDialogState();
}

class _BreakEndDialogState extends State<BreakEndDialog> {
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
                color: Colors.orange,
                size: 40.0,
              ),
              SizedBox(width: 8.0),
              Icon(
                Icons.arrow_right_alt,
                color: Colors.orange,
                size: 40.0,
              ),
              SizedBox(width: 8.0),
              Icon(
                Icons.list_alt,
                color: Colors.orange,
                size: 40.0,
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Text('休憩終了時間を記録します。よろしいですか？'),
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
                onPressed: () async {
                  if (!await widget.userWorkProvider.breakEnd(
                    user: widget.userProvider.user,
                    locations: widget.locations,
                  )) {
                    return;
                  }
                  widget.userProvider.reloadUserModel();
                  Navigator.pop(context);
                },
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
