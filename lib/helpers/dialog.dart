import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/user_work.dart';
import 'package:hatarakujikan_app/widgets/custom_dialog.dart';

class WorkStartDialog extends StatelessWidget {
  final UserProvider userProvider;
  final UserWorkProvider userWorkProvider;
  final double longitude;
  final double latitude;

  WorkStartDialog({
    @required this.userProvider,
    @required this.userWorkProvider,
    @required this.longitude,
    @required this.latitude,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: '出勤',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('出勤時間を打刻します。'),
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
                  if (!await userWorkProvider.createWorkStart(
                      user: userProvider.user,
                      longitude: longitude,
                      latitude: latitude)) {
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
