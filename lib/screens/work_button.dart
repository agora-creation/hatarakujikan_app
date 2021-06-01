import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/work.dart';
import 'package:hatarakujikan_app/widgets/custom_text_button.dart';
import 'package:hatarakujikan_app/widgets/custom_work_button.dart';

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
                    ? CustomWorkButton(
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
                        labelText: '出勤',
                        labelColor: Color(0xFFFEFFFA),
                        backgroundColor: Colors.blue,
                        borderColor: null,
                      )
                    : CustomWorkButton(
                        onPressed: null,
                        labelText: '出勤',
                        labelColor: Color(0xFFFEFFFA),
                        backgroundColor: Colors.grey,
                        borderColor: null,
                      ),
              ),
              SizedBox(width: 1.0),
              Expanded(
                child: !workError && userProvider.user?.workLv == 1
                    ? CustomWorkButton(
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
                        labelText: '退勤',
                        labelColor: Color(0xFFFEFFFA),
                        backgroundColor: Colors.red,
                        borderColor: null,
                      )
                    : CustomWorkButton(
                        onPressed: null,
                        labelText: '退勤',
                        labelColor: Color(0xFFFEFFFA),
                        backgroundColor: Colors.grey,
                        borderColor: null,
                      ),
              ),
            ],
          ),
          SizedBox(height: 1.0),
          Row(
            children: [
              Expanded(
                child: !workError && userProvider.user?.workLv == 1
                    ? CustomWorkButton(
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
                        labelText: '休憩開始',
                        labelColor: Color(0xFFFEFFFA),
                        backgroundColor: Colors.orange,
                        borderColor: null,
                      )
                    : CustomWorkButton(
                        onPressed: null,
                        labelText: '休憩開始',
                        labelColor: Color(0xFFFEFFFA),
                        backgroundColor: Colors.grey,
                        borderColor: null,
                      ),
              ),
              SizedBox(width: 1.0),
              Expanded(
                child: !workError && userProvider.user?.workLv == 2
                    ? CustomWorkButton(
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
                        labelText: '休憩終了',
                        labelColor: Colors.orange,
                        backgroundColor: Color(0xFFFEFFFA),
                        borderColor: Colors.orange,
                      )
                    : CustomWorkButton(
                        onPressed: null,
                        labelText: '休憩終了',
                        labelColor: Color(0xFFFEFFFA),
                        backgroundColor: Colors.grey,
                        borderColor: null,
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
              CustomTextButton(
                onPressed: () => Navigator.pop(context),
                labelText: 'キャンセル',
                backgroundColor: Colors.grey,
              ),
              CustomTextButton(
                onPressed: () async {
                  if (!await workProvider.workStart(
                    group: userProvider.group,
                    user: userProvider.user,
                    locations: locations,
                  )) {
                    return;
                  }
                  userProvider.reloadUserModel();
                  Navigator.pop(context);
                },
                labelText: 'はい',
                backgroundColor: Colors.blue,
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
              CustomTextButton(
                onPressed: () => Navigator.pop(context),
                labelText: 'キャンセル',
                backgroundColor: Colors.grey,
              ),
              CustomTextButton(
                onPressed: () async {
                  if (!await workProvider.workEnd(
                    group: userProvider.group,
                    user: userProvider.user,
                    locations: locations,
                  )) {
                    return;
                  }
                  userProvider.reloadUserModel();
                  Navigator.pop(context);
                },
                labelText: 'はい',
                backgroundColor: Colors.blue,
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
              CustomTextButton(
                onPressed: () => Navigator.pop(context),
                labelText: 'キャンセル',
                backgroundColor: Colors.grey,
              ),
              CustomTextButton(
                onPressed: () async {
                  if (!await workProvider.breakStart(
                    group: userProvider.group,
                    user: userProvider.user,
                    locations: locations,
                  )) {
                    return;
                  }
                  userProvider.reloadUserModel();
                  Navigator.pop(context);
                },
                labelText: 'はい',
                backgroundColor: Colors.blue,
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
              CustomTextButton(
                onPressed: () => Navigator.pop(context),
                labelText: 'キャンセル',
                backgroundColor: Colors.grey,
              ),
              CustomTextButton(
                onPressed: () async {
                  if (!await workProvider.breakEnd(
                    group: userProvider.group,
                    user: userProvider.user,
                    locations: locations,
                  )) {
                    return;
                  }
                  userProvider.reloadUserModel();
                  Navigator.pop(context);
                },
                labelText: 'はい',
                backgroundColor: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
