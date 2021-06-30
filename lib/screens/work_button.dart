import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/dialogs.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/work.dart';
import 'package:hatarakujikan_app/screens/break_end_qr.dart';
import 'package:hatarakujikan_app/screens/break_start_qr.dart';
import 'package:hatarakujikan_app/screens/work_end_qr.dart';
import 'package:hatarakujikan_app/screens/work_start_qr.dart';
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
    if (!workError && userProvider.user?.workLv == 0) {
      // 未出勤
      return Container(
        color: Color(0xFFFEFFFA),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomWorkButton(
                    onPressed: () async {
                      if (userProvider.group?.qrSecurity == true) {
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
                      } else {
                        await showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) => WorkStartDialog(
                            userProvider: userProvider,
                            workProvider: workProvider,
                            locations: locations,
                            state: '通常勤務',
                          ),
                        );
                      }
                    },
                    label: '出勤',
                    color: Color(0xFFFEFFFA),
                    backgroundColor: Colors.blue,
                    borderColor: null,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.0),
            Row(
              children: [
                Expanded(
                  child: CustomWorkButton(
                    onPressed: () async {
                      await showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => WorkStartDialog(
                          userProvider: userProvider,
                          workProvider: workProvider,
                          locations: locations,
                          state: '直行/直帰',
                        ),
                      );
                    },
                    label: '直行',
                    color: Color(0xFFFEFFFA),
                    backgroundColor: Colors.teal,
                    borderColor: null,
                  ),
                ),
                SizedBox(width: 1.0),
                Expanded(
                  child: CustomWorkButton(
                    onPressed: () async {
                      await showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => WorkStartDialog(
                          userProvider: userProvider,
                          workProvider: workProvider,
                          locations: locations,
                          state: 'テレワーク',
                        ),
                      );
                    },
                    label: 'テレワーク出勤',
                    color: Color(0xFFFEFFFA),
                    backgroundColor: Colors.cyan,
                    borderColor: null,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (!workError && userProvider.user?.workLv == 1) {
      // 出勤中
      return Container(
        color: Color(0xFFFEFFFA),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomWorkButton(
                    onPressed: () async {
                      if (userProvider.group?.qrSecurity == true) {
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
                    },
                    label: '退勤',
                    color: Color(0xFFFEFFFA),
                    backgroundColor: Colors.red,
                    borderColor: null,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.0),
            Row(
              children: [
                Expanded(
                  child: CustomWorkButton(
                    onPressed: () async {
                      if (userProvider.group?.qrSecurity == true) {
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
                    },
                    label: '休憩開始',
                    color: Color(0xFFFEFFFA),
                    backgroundColor: Colors.orange,
                    borderColor: null,
                  ),
                ),
                SizedBox(width: 1.0),
                Expanded(
                  child: CustomWorkButton(
                    onPressed: null,
                    label: '休憩終了',
                    color: Color(0xFFFEFFFA),
                    backgroundColor: Colors.grey,
                    borderColor: null,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (!workError && userProvider.user?.workLv == 2) {
      // 直行中
      return Container(
        color: Color(0xFFFEFFFA),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomWorkButton(
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
                    label: '直帰',
                    color: Color(0xFFFEFFFA),
                    backgroundColor: Colors.red,
                    borderColor: null,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.0),
            Row(
              children: [
                Expanded(
                  child: CustomWorkButton(
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
                    label: '休憩開始',
                    color: Color(0xFFFEFFFA),
                    backgroundColor: Colors.orange,
                    borderColor: null,
                  ),
                ),
                SizedBox(width: 1.0),
                Expanded(
                  child: CustomWorkButton(
                    onPressed: null,
                    label: '休憩終了',
                    color: Color(0xFFFEFFFA),
                    backgroundColor: Colors.grey,
                    borderColor: null,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (!workError && userProvider.user?.workLv == 3) {
      // テレワーク中
      return Container(
        color: Color(0xFFFEFFFA),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomWorkButton(
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
                    label: 'テレワーク退勤',
                    color: Color(0xFFFEFFFA),
                    backgroundColor: Colors.red,
                    borderColor: null,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.0),
            Row(
              children: [
                Expanded(
                  child: CustomWorkButton(
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
                    label: '休憩開始',
                    color: Color(0xFFFEFFFA),
                    backgroundColor: Colors.orange,
                    borderColor: null,
                  ),
                ),
                SizedBox(width: 1.0),
                Expanded(
                  child: CustomWorkButton(
                    onPressed: null,
                    label: '休憩終了',
                    color: Color(0xFFFEFFFA),
                    backgroundColor: Colors.grey,
                    borderColor: null,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (!workError && userProvider.user?.workLv == 91) {
      // 出勤休憩中
      return Container(
        color: Color(0xFFFEFFFA),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomWorkButton(
                    onPressed: null,
                    label: '退勤',
                    color: Color(0xFFFEFFFA),
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
                  child: CustomWorkButton(
                    onPressed: null,
                    label: '休憩開始',
                    color: Color(0xFFFEFFFA),
                    backgroundColor: Colors.grey,
                    borderColor: null,
                  ),
                ),
                SizedBox(width: 1.0),
                Expanded(
                  child: CustomWorkButton(
                    onPressed: () async {
                      if (userProvider.group?.qrSecurity == true) {
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
                    },
                    label: '休憩終了',
                    color: Colors.orange,
                    backgroundColor: Color(0xFFFEFFFA),
                    borderColor: Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (!workError && userProvider.user?.workLv == 92) {
      // 直行休憩中
      return Container(
        color: Color(0xFFFEFFFA),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomWorkButton(
                    onPressed: null,
                    label: '直帰',
                    color: Color(0xFFFEFFFA),
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
                  child: CustomWorkButton(
                    onPressed: null,
                    label: '休憩開始',
                    color: Color(0xFFFEFFFA),
                    backgroundColor: Colors.grey,
                    borderColor: null,
                  ),
                ),
                SizedBox(width: 1.0),
                Expanded(
                  child: CustomWorkButton(
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
                    label: '休憩終了',
                    color: Colors.orange,
                    backgroundColor: Color(0xFFFEFFFA),
                    borderColor: Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (!workError && userProvider.user?.workLv == 93) {
      // テレワーク休憩中
      return Container(
        color: Color(0xFFFEFFFA),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomWorkButton(
                    onPressed: null,
                    label: 'テレワーク退勤',
                    color: Color(0xFFFEFFFA),
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
                  child: CustomWorkButton(
                    onPressed: null,
                    label: '休憩開始',
                    color: Color(0xFFFEFFFA),
                    backgroundColor: Colors.grey,
                    borderColor: null,
                  ),
                ),
                SizedBox(width: 1.0),
                Expanded(
                  child: CustomWorkButton(
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
                    label: '休憩終了',
                    color: Colors.orange,
                    backgroundColor: Color(0xFFFEFFFA),
                    borderColor: Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
