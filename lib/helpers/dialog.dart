import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/user_work.dart';
import 'package:hatarakujikan_app/widgets/custom_dialog.dart';
import 'package:intl/intl.dart';

class WorkStartDialog extends StatefulWidget {
  final UserModel user;
  final UserProvider userProvider;
  final UserWorkProvider userWorkProvider;
  final double longitude;
  final double latitude;

  WorkStartDialog({
    @required this.user,
    @required this.userProvider,
    @required this.userWorkProvider,
    @required this.longitude,
    @required this.latitude,
  });

  @override
  _WorkStartDialogState createState() => _WorkStartDialogState();
}

class _WorkStartDialogState extends State<WorkStartDialog> {
  String _date = '';
  String _time = '';

  void _onTimer(Timer timer) {
    var _now = DateTime.now();
    var _dateText = DateFormat('yyyy/MM/dd (E)', 'ja').format(_now);
    var _timeText = DateFormat('HH:mm:ss').format(_now);
    if (mounted) {
      setState(() {
        _date = _dateText;
        _time = _timeText;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), _onTimer);
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: '出勤',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text(_date, style: kDateTextStyle)),
          Center(child: Text(_time, style: kTimeTextStyle)),
          SizedBox(height: 8.0),
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
                  if (!await widget.userWorkProvider.createWorkStart(
                      user: widget.user,
                      longitude: widget.longitude,
                      latitude: widget.latitude)) {
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
  final UserModel user;
  final UserProvider userProvider;
  final UserWorkProvider userWorkProvider;
  final double longitude;
  final double latitude;

  WorkEndDialog({
    @required this.user,
    @required this.userProvider,
    @required this.userWorkProvider,
    @required this.longitude,
    @required this.latitude,
  });

  @override
  _WorkEndDialogState createState() => _WorkEndDialogState();
}

class _WorkEndDialogState extends State<WorkEndDialog> {
  String _date = '';
  String _time = '';

  void _onTimer(Timer timer) {
    var _now = DateTime.now();
    var _dateText = DateFormat('yyyy/MM/dd (E)', 'ja').format(_now);
    var _timeText = DateFormat('HH:mm:ss').format(_now);
    if (mounted) {
      setState(() {
        _date = _dateText;
        _time = _timeText;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), _onTimer);
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: '退勤',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text(_date, style: kDateTextStyle)),
          Center(child: Text(_time, style: kTimeTextStyle)),
          SizedBox(height: 8.0),
          Text('退勤時間を打刻します。'),
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
                  if (!await widget.userWorkProvider.updateWorkEnd(
                      user: widget.user,
                      longitude: widget.longitude,
                      latitude: widget.latitude)) {
                    return;
                  }
                  widget.userProvider.reloadUserModel();
                  Navigator.pop(context);
                },
                child: Text('はい', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(backgroundColor: Colors.red),
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
