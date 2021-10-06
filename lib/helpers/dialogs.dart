import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/work.dart';
import 'package:hatarakujikan_app/widgets/custom_text_button.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';
import 'package:permission_handler/permission_handler.dart';

class UpdaterDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'アップデートのお知らせ',
        style: TextStyle(fontSize: 18.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('各種パフォーマンスの改善および新機能を追加しました。最新バージョンへのアップデートをお願いします。'),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextButton(
                onPressed: () => Navigator.pop(context),
                label: 'キャンセル',
                color: Colors.grey,
              ),
              CustomTextButton(
                onPressed: () => launchUpdate(),
                label: 'アップデート',
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PermissionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'カメラを許可してください',
        style: TextStyle(fontSize: 18.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('QRコードを読み取る為にカメラを利用します'),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextButton(
                onPressed: () => Navigator.pop(context),
                label: 'キャンセル',
                color: Colors.grey,
              ),
              CustomTextButton(
                onPressed: () => openAppSettings(),
                label: 'はい',
                color: Colors.blue,
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
  final WorkProvider workProvider;
  final List<double> locations;
  final String state;

  WorkStartDialog({
    @required this.userProvider,
    @required this.workProvider,
    @required this.locations,
    @required this.state,
  });

  @override
  _WorkStartDialogState createState() => _WorkStartDialogState();
}

class _WorkStartDialogState extends State<WorkStartDialog> {
  void _init() async {
    await Future.delayed(Duration(seconds: 2));
    await widget.workProvider
        .workStart(
      group: widget.userProvider.group,
      user: widget.userProvider.user,
      locations: widget.locations,
      state: widget.state,
    )
        .then((value) {
      widget.userProvider.reloadUserModel();
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('出勤時間を記録中です'),
          SizedBox(height: 16.0),
          Loading(color: Colors.cyan),
        ],
      ),
    );
  }
}

class WorkEndDialog extends StatefulWidget {
  final UserProvider userProvider;
  final WorkProvider workProvider;
  final List<double> locations;

  WorkEndDialog({
    @required this.userProvider,
    @required this.workProvider,
    @required this.locations,
  });

  @override
  _WorkEndDialogState createState() => _WorkEndDialogState();
}

class _WorkEndDialogState extends State<WorkEndDialog> {
  void _init() async {
    await Future.delayed(Duration(seconds: 2));
    await widget.workProvider
        .workEnd(
      group: widget.userProvider.group,
      user: widget.userProvider.user,
      locations: widget.locations,
    )
        .then((value) {
      widget.userProvider.reloadUserModel();
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('退勤時間を記録中です'),
          SizedBox(height: 16.0),
          Loading(color: Colors.cyan),
        ],
      ),
    );
  }
}

class BreakStartDialog extends StatefulWidget {
  final UserProvider userProvider;
  final WorkProvider workProvider;
  final List<double> locations;

  BreakStartDialog({
    @required this.userProvider,
    @required this.workProvider,
    @required this.locations,
  });

  @override
  _BreakStartDialogState createState() => _BreakStartDialogState();
}

class _BreakStartDialogState extends State<BreakStartDialog> {
  void _init() async {
    await Future.delayed(Duration(seconds: 2));
    await widget.workProvider
        .breakStart(
      group: widget.userProvider.group,
      user: widget.userProvider.user,
      locations: widget.locations,
    )
        .then((value) {
      widget.userProvider.reloadUserModel();
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('休憩開始時間を記録中です'),
          SizedBox(height: 16.0),
          Loading(color: Colors.cyan),
        ],
      ),
    );
  }
}

class BreakEndDialog extends StatefulWidget {
  final UserProvider userProvider;
  final WorkProvider workProvider;
  final List<double> locations;

  BreakEndDialog({
    @required this.userProvider,
    @required this.workProvider,
    @required this.locations,
  });

  @override
  _BreakEndDialogState createState() => _BreakEndDialogState();
}

class _BreakEndDialogState extends State<BreakEndDialog> {
  void _init() async {
    await Future.delayed(Duration(seconds: 2));
    await widget.workProvider
        .breakEnd(
      group: widget.userProvider.group,
      user: widget.userProvider.user,
      locations: widget.locations,
    )
        .then((value) {
      widget.userProvider.reloadUserModel();
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('休憩終了時間を記録中です'),
          SizedBox(height: 16.0),
          Loading(color: Colors.cyan),
        ],
      ),
    );
  }
}
