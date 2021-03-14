import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/user_work.dart';
import 'package:hatarakujikan_app/widgets/custom_dialog.dart';

class WorkStartDialog extends StatelessWidget {
  final UserModel user;
  final UserProvider userProvider;
  final UserWorkProvider userWorkProvider;

  WorkStartDialog({
    @required this.user,
    @required this.userProvider,
    @required this.userWorkProvider,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: '出勤する',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('出勤時間を記録します。'),
          Text('よろしいですか？'),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('いいえ', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(backgroundColor: Colors.grey),
              ),
              TextButton(
                onPressed: () async {
                  if (!await userWorkProvider.createWorkStart(user: user)) {
                    return;
                  }
                  userProvider.reloadUserModel();
                  Navigator.pop(context);
                },
                child: Text('はい', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WorkEndDialog extends StatelessWidget {
  final UserModel user;
  final UserProvider userProvider;
  final UserWorkProvider userWorkProvider;

  WorkEndDialog({
    @required this.user,
    @required this.userProvider,
    @required this.userWorkProvider,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: '退勤する',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('退勤時間を記録します。'),
          Text('よろしいですか？'),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('いいえ', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(backgroundColor: Colors.grey),
              ),
              TextButton(
                onPressed: () async {
                  if (!await userWorkProvider.updateWorkEnd(user: user)) {
                    return;
                  }
                  userProvider.reloadUserModel();
                  Navigator.pop(context);
                },
                child: Text('はい', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WorkBreakStartDialog extends StatelessWidget {
  final UserModel user;
  final UserProvider userProvider;
  final UserWorkProvider userWorkProvider;

  WorkBreakStartDialog({
    @required this.user,
    @required this.userProvider,
    @required this.userWorkProvider,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: '休憩する',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('休憩時間を記録します。'),
          Text('よろしいですか？'),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('いいえ', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(backgroundColor: Colors.grey),
              ),
              TextButton(
                onPressed: () async {
                  if (!await userWorkProvider.createWorkStart(user: user)) {
                    return;
                  }
                  userProvider.reloadUserModel();
                  Navigator.pop(context);
                },
                child: Text('はい', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WorkBreakEndDialog extends StatelessWidget {
  final UserModel user;
  final UserProvider userProvider;
  final UserWorkProvider userWorkProvider;

  WorkBreakEndDialog({
    @required this.user,
    @required this.userProvider,
    @required this.userWorkProvider,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: '休憩をやめる',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('休憩時間を記録します。'),
          Text('よろしいですか？'),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('いいえ', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(backgroundColor: Colors.grey),
              ),
              TextButton(
                onPressed: () async {
                  if (!await userWorkProvider.updateWorkEnd(user: user)) {
                    return;
                  }
                  userProvider.reloadUserModel();
                  Navigator.pop(context);
                },
                child: Text('はい', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
