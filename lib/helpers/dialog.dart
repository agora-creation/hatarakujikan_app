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
                style: TextButton.styleFrom(backgroundColor: Colors.redAccent),
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
                  if (!await userWorkProvider.createWorkBreakStart(
                      user: user)) {
                    return;
                  }
                  userProvider.reloadUserModel();
                  Navigator.pop(context);
                },
                child: Text('はい', style: TextStyle(color: Colors.white)),
                style:
                    TextButton.styleFrom(backgroundColor: Colors.orangeAccent),
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
                  if (!await userWorkProvider.updateWorkBreakEnd(user: user)) {
                    return;
                  }
                  userProvider.reloadUserModel();
                  Navigator.pop(context);
                },
                child: Text('はい', style: TextStyle(color: Colors.white)),
                style:
                    TextButton.styleFrom(backgroundColor: Colors.orangeAccent),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WorkTotalDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: '2021年3月',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '勤務時間',
            style: TextStyle(color: Colors.grey, fontSize: 14.0),
          ),
          Text('100:00'),
          Text(
            '深夜労働時間',
            style: TextStyle(color: Colors.grey, fontSize: 14.0),
          ),
          Text('100:00'),
          Text(
            '残業時間',
            style: TextStyle(color: Colors.grey, fontSize: 14.0),
          ),
          Text('100:00'),
          SizedBox(height: 16.0),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('閉じる', style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(backgroundColor: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class LocationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: '位置情報エラー',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('位置情報がうまく取得できませんでした。'),
          Text('お使いのスマートフォンの設定から位置情報の取得を許可してください。'),
          SizedBox(height: 16.0),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('閉じる', style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(backgroundColor: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
