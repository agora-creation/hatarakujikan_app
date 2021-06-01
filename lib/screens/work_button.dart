import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/work.dart';
import 'package:hatarakujikan_app/screens/break_end_qr.dart';
import 'package:hatarakujikan_app/screens/break_start_qr.dart';
import 'package:hatarakujikan_app/screens/work_end_qr.dart';
import 'package:hatarakujikan_app/screens/work_start_qr.dart';
import 'package:hatarakujikan_app/widgets/custom_text_button.dart';
import 'package:hatarakujikan_app/widgets/custom_work_button.dart';
import 'package:permission_handler/permission_handler.dart';

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
                        onPressed: () async {
                          if (await Permission.camera.request().isGranted) {
                            overlayScreen(
                              context,
                              WorkStartQRScreen(
                                userProvider: userProvider,
                                workProvider: workProvider,
                                locations: locations,
                              ),
                            );
                          } else {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => PermissionDialog(),
                            );
                          }
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
                        onPressed: () async {
                          if (await Permission.camera.request().isGranted) {
                            overlayScreen(
                              context,
                              WorkEndQRScreen(
                                userProvider: userProvider,
                                workProvider: workProvider,
                                locations: locations,
                              ),
                            );
                          } else {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => PermissionDialog(),
                            );
                          }
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
                        onPressed: () async {
                          if (await Permission.camera.request().isGranted) {
                            overlayScreen(
                              context,
                              BreakStartQRScreen(
                                userProvider: userProvider,
                                workProvider: workProvider,
                                locations: locations,
                              ),
                            );
                          } else {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => PermissionDialog(),
                            );
                          }
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
                        onPressed: () async {
                          if (await Permission.camera.request().isGranted) {
                            overlayScreen(
                              context,
                              BreakEndQRScreen(
                                userProvider: userProvider,
                                workProvider: workProvider,
                                locations: locations,
                              ),
                            );
                          } else {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => PermissionDialog(),
                            );
                          }
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
                labelText: 'キャンセル',
                backgroundColor: Colors.grey,
              ),
              CustomTextButton(
                onPressed: () => openAppSettings(),
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
