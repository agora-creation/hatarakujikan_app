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
                onPressed: () async {},
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
