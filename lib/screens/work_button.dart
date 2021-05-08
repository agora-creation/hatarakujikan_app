import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/work.dart';

class WorkButton extends StatelessWidget {
  final UserProvider userProvider;
  final WorkProvider workProvider;
  final List<double> locations;
  final bool workError;

  WorkButton({
    @required this.userProvider,
    @required this.workProvider,
    @required this.locations,
    @required this.workError,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFEFFFA),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: !workError && userProvider.user?.workLv == 0
                    ? TextButton(
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) => WorkStartDialog(
                              userProvider: userProvider,
                              workProvider: workProvider,
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
                child: !workError && userProvider.user?.workLv == 1
                    ? TextButton(
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) => WorkEndDialog(
                              userProvider: userProvider,
                              workProvider: workProvider,
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
                child: !workError && userProvider.user?.workLv == 1
                    ? TextButton(
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) => BreakStartDialog(
                              userProvider: userProvider,
                              workProvider: workProvider,
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
                child: !workError && userProvider.user?.workLv == 2
                    ? TextButton(
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) => BreakEndDialog(
                              userProvider: userProvider,
                              workProvider: workProvider,
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
                          side: BorderSide(color: Colors.orange, width: 1),
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

class WorkStartDialog extends StatelessWidget {
  final UserProvider userProvider;
  final WorkProvider workProvider;
  final List<double> locations;

  WorkStartDialog({
    @required this.userProvider,
    @required this.workProvider,
    @required this.locations,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Icon(
              Icons.run_circle,
              color: Colors.blue,
              size: 40.0,
            ),
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
                  if (!await workProvider.workStart(
                    user: userProvider.user,
                    group: userProvider.group,
                    locations: locations,
                  )) {
                    return;
                  }
                  userProvider.reloadUserModel();
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

class WorkEndDialog extends StatelessWidget {
  final UserProvider userProvider;
  final WorkProvider workProvider;
  final List<double> locations;

  WorkEndDialog({
    @required this.userProvider,
    @required this.workProvider,
    @required this.locations,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Icon(
              Icons.run_circle,
              color: Colors.red,
              size: 40.0,
            ),
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
                  if (!await workProvider.workEnd(
                    user: userProvider.user,
                    locations: locations,
                  )) {
                    return;
                  }
                  userProvider.reloadUserModel();
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

class BreakStartDialog extends StatelessWidget {
  final UserProvider userProvider;
  final WorkProvider workProvider;
  final List<double> locations;

  BreakStartDialog({
    @required this.userProvider,
    @required this.workProvider,
    @required this.locations,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Icon(
              Icons.run_circle,
              color: Colors.orange,
              size: 40.0,
            ),
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
                  if (!await workProvider.breakStart(
                    user: userProvider.user,
                    locations: locations,
                  )) {
                    return;
                  }
                  userProvider.reloadUserModel();
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

class BreakEndDialog extends StatelessWidget {
  final UserProvider userProvider;
  final WorkProvider workProvider;
  final List<double> locations;

  BreakEndDialog({
    @required this.userProvider,
    @required this.workProvider,
    @required this.locations,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Icon(
              Icons.run_circle_outlined,
              color: Colors.orange,
              size: 40.0,
            ),
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
                  if (!await workProvider.breakEnd(
                    user: userProvider.user,
                    locations: locations,
                  )) {
                    return;
                  }
                  userProvider.reloadUserModel();
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
