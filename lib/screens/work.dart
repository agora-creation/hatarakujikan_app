import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/dialog.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/user_work.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';
import 'package:hatarakujikan_app/widgets/round_border_button.dart';

class WorkScreen extends StatelessWidget {
  final UserModel user;
  final UserProvider userProvider;
  final UserWorkProvider userWorkProvider;

  WorkScreen({
    @required this.user,
    @required this.userProvider,
    @required this.userWorkProvider,
  });

  @override
  Widget build(BuildContext context) {
    final double _deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: _deviceWidth,
              height: _deviceWidth,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey,
                  width: 8.0,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('2021/03/12(金)', style: kDateTextStyle),
                  Text('18:20', style: kTimeTextStyle),
                  SizedBox(height: 8.0),
                  Text(
                    '未出勤',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                user.workId == ''
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: RoundBackgroundButton(
                          labelText: '出勤する',
                          labelColor: Colors.white,
                          backgroundColor: Colors.blueAccent,
                          labelFontSize: 16.0,
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => WorkStartDialog(
                                user: user,
                                userProvider: userProvider,
                                userWorkProvider: userWorkProvider,
                              ),
                            );
                          },
                        ),
                      )
                    : Container(),
                user.workId != ''
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: RoundBackgroundButton(
                          labelText: '退勤する',
                          labelColor: Colors.white,
                          backgroundColor: Colors.redAccent,
                          labelFontSize: 16.0,
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => WorkEndDialog(
                                user: user,
                                userProvider: userProvider,
                                userWorkProvider: userWorkProvider,
                              ),
                            );
                          },
                        ),
                      )
                    : Container(),
                user.workBreakId == '' && user.workId != ''
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: RoundBackgroundButton(
                          labelText: '休憩する',
                          labelColor: Colors.white,
                          backgroundColor: Colors.orangeAccent,
                          labelFontSize: 16.0,
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => WorkBreakStartDialog(
                                user: user,
                                userProvider: userProvider,
                                userWorkProvider: userWorkProvider,
                              ),
                            );
                          },
                        ),
                      )
                    : Container(),
                user.workBreakId != '' && user.workId != ''
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: RoundBorderButton(
                          labelText: '休憩をやめる',
                          labelColor: Colors.orangeAccent,
                          borderColor: Colors.orangeAccent,
                          labelFontSize: 16.0,
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => WorkBreakEndDialog(
                                user: user,
                                userProvider: userProvider,
                                userWorkProvider: userWorkProvider,
                              ),
                            );
                          },
                        ),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
