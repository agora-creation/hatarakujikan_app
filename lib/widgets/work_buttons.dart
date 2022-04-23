import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/define.dart';
import 'package:hatarakujikan_app/helpers/dialogs.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/work.dart';
import 'package:hatarakujikan_app/screens/break_end_qr.dart';
import 'package:hatarakujikan_app/screens/break_start_qr.dart';
import 'package:hatarakujikan_app/screens/work_end_qr.dart';
import 'package:hatarakujikan_app/screens/work_start_qr.dart';
import 'package:hatarakujikan_app/widgets/work_button.dart';
import 'package:permission_handler/permission_handler.dart';

class WorkButtons extends StatelessWidget {
  final UserProvider userProvider;
  final WorkProvider workProvider;
  final List<double> locations;
  final bool? error;
  final bool? locationError;

  WorkButtons({
    required this.userProvider,
    required this.workProvider,
    required this.locations,
    this.error,
    this.locationError,
  });

  @override
  Widget build(BuildContext context) {
    UserModel? _user = userProvider.user;
    GroupModel? _group = userProvider.group;
    if (error == true) return Container();
    List<Widget> _children = [];
    switch (_user?.workLv) {
      case 0: //未出勤
        _children = [
          Row(
            children: [
              WorkButton(
                label: '出勤',
                color: Color(0xFFFEFFFA),
                backgroundColor:
                    locationError == false ? Colors.blue : Colors.grey,
                onPressed: locationError == false
                    ? () async {
                        if (_group?.qrSecurity == true) {
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
                            await showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => PermissionDialog(),
                            );
                          }
                        } else {
                          await showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) => WorkStartDialog(
                              userProvider: userProvider,
                              workProvider: workProvider,
                              locations: locations,
                              state: workStates[0],
                            ),
                          );
                        }
                      }
                    : null,
              ),
            ],
          ),
          SizedBox(height: 1.0),
          Row(
            children: [
              WorkButton(
                label: '直行',
                color: Color(0xFFFEFFFA),
                backgroundColor: Colors.teal,
                onPressed: () async {
                  await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => WorkStartDialog(
                      userProvider: userProvider,
                      workProvider: workProvider,
                      locations: locations,
                      state: workStates[1],
                    ),
                  );
                },
              ),
              SizedBox(width: 1.0),
              WorkButton(
                label: 'テレワーク出勤',
                color: Color(0xFFFEFFFA),
                backgroundColor: Colors.cyan,
                onPressed: () async {
                  await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => WorkStartDialog(
                      userProvider: userProvider,
                      workProvider: workProvider,
                      locations: locations,
                      state: workStates[2],
                    ),
                  );
                },
              ),
            ],
          ),
        ];
        break;
      case 1: //出勤中
        _children = [
          Row(
            children: [
              WorkButton(
                label: '退勤',
                color: Color(0xFFFEFFFA),
                backgroundColor:
                    locationError == false ? Colors.red : Colors.grey,
                onPressed: locationError == false
                    ? () async {
                        if (_group?.qrSecurity == true) {
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
                            await showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => PermissionDialog(),
                            );
                          }
                        } else {
                          await showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) => WorkEndDialog(
                              userProvider: userProvider,
                              workProvider: workProvider,
                              locations: locations,
                            ),
                          );
                        }
                      }
                    : null,
              ),
            ],
          ),
          SizedBox(height: 1.0),
          Row(
            children: [
              WorkButton(
                label: '休憩開始',
                color: Color(0xFFFEFFFA),
                backgroundColor:
                    locationError == false ? Colors.orange : Colors.grey,
                onPressed: locationError == false
                    ? () async {
                        if (_group?.qrSecurity == true) {
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
                            await showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => PermissionDialog(),
                            );
                          }
                        } else {
                          await showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) => BreakStartDialog(
                              userProvider: userProvider,
                              workProvider: workProvider,
                              locations: locations,
                            ),
                          );
                        }
                      }
                    : null,
              ),
              SizedBox(width: 1.0),
              WorkButton(
                label: '休憩終了',
                color: Color(0xFFFEFFFA),
                backgroundColor: Colors.grey,
              ),
            ],
          ),
        ];
        break;
      case 2: //直行中
        _children = [
          Row(
            children: [
              WorkButton(
                label: '直帰',
                color: Color(0xFFFEFFFA),
                backgroundColor: Colors.red,
                onPressed: () async {
                  await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => WorkEndDialog(
                      userProvider: userProvider,
                      workProvider: workProvider,
                      locations: locations,
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 1.0),
          Row(
            children: [
              WorkButton(
                label: '休憩開始',
                color: Color(0xFFFEFFFA),
                backgroundColor: Colors.orange,
                onPressed: () async {
                  await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => BreakStartDialog(
                      userProvider: userProvider,
                      workProvider: workProvider,
                      locations: locations,
                    ),
                  );
                },
              ),
              SizedBox(width: 1.0),
              WorkButton(
                label: '休憩終了',
                color: Color(0xFFFEFFFA),
                backgroundColor: Colors.grey,
              ),
            ],
          ),
        ];
        break;
      case 3: //テレワーク中
        _children = [
          Row(
            children: [
              WorkButton(
                label: 'テレワーク退勤',
                color: Color(0xFFFEFFFA),
                backgroundColor: Colors.red,
                onPressed: () async {
                  await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => WorkEndDialog(
                      userProvider: userProvider,
                      workProvider: workProvider,
                      locations: locations,
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 1.0),
          Row(
            children: [
              WorkButton(
                label: '休憩開始',
                color: Color(0xFFFEFFFA),
                backgroundColor: Colors.orange,
                onPressed: () async {
                  await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => BreakStartDialog(
                      userProvider: userProvider,
                      workProvider: workProvider,
                      locations: locations,
                    ),
                  );
                },
              ),
              SizedBox(width: 1.0),
              WorkButton(
                label: '休憩終了',
                color: Color(0xFFFEFFFA),
                backgroundColor: Colors.grey,
              ),
            ],
          ),
        ];
        break;
      case 91: //出勤休憩中
        _children = [
          Row(
            children: [
              WorkButton(
                label: '退勤',
                color: Color(0xFFFEFFFA),
                backgroundColor: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 1.0),
          Row(
            children: [
              WorkButton(
                label: '休憩開始',
                color: Color(0xFFFEFFFA),
                backgroundColor: Colors.grey,
              ),
              SizedBox(width: 1.0),
              WorkButton(
                label: '休憩終了',
                color:
                    locationError == false ? Colors.orange : Color(0xFFFEFFFA),
                backgroundColor:
                    locationError == false ? Color(0xFFFEFFFA) : Colors.grey,
                borderColor: locationError == false ? Colors.orange : null,
                onPressed: locationError == false
                    ? () async {
                        if (_group?.qrSecurity == true) {
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
                            await showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => PermissionDialog(),
                            );
                          }
                        } else {
                          await showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) => BreakEndDialog(
                              userProvider: userProvider,
                              workProvider: workProvider,
                              locations: locations,
                            ),
                          );
                        }
                      }
                    : null,
              ),
            ],
          ),
        ];
        break;
      case 92: //直行休憩中
        _children = [
          Row(
            children: [
              WorkButton(
                label: '直帰',
                color: Color(0xFFFEFFFA),
                backgroundColor: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 1.0),
          Row(
            children: [
              WorkButton(
                label: '休憩開始',
                color: Color(0xFFFEFFFA),
                backgroundColor: Colors.grey,
              ),
              SizedBox(width: 1.0),
              WorkButton(
                label: '休憩終了',
                color: Colors.orange,
                backgroundColor: Color(0xFFFEFFFA),
                borderColor: Colors.orange,
                onPressed: () async {
                  await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => BreakEndDialog(
                      userProvider: userProvider,
                      workProvider: workProvider,
                      locations: locations,
                    ),
                  );
                },
              ),
            ],
          ),
        ];
        break;
      case 93: //テレワーク休憩中
        _children = [
          Row(
            children: [
              WorkButton(
                label: 'テレワーク退勤',
                color: Color(0xFFFEFFFA),
                backgroundColor: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 1.0),
          Row(
            children: [
              WorkButton(
                label: '休憩開始',
                color: Color(0xFFFEFFFA),
                backgroundColor: Colors.grey,
              ),
              SizedBox(width: 1.0),
              WorkButton(
                label: '休憩終了',
                color: Colors.orange,
                backgroundColor: Color(0xFFFEFFFA),
                borderColor: Colors.orange,
                onPressed: () async {
                  await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => BreakEndDialog(
                      userProvider: userProvider,
                      workProvider: workProvider,
                      locations: locations,
                    ),
                  );
                },
              ),
            ],
          ),
        ];
        break;
    }

    return Container(
      color: Color(0xFFFEFFFA),
      child: Column(
        children: _children,
      ),
    );
  }
}
