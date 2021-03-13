import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/user_work.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';

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
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
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
                  SizedBox(height: 4.0),
                  Text('18:20', style: kTimeTextStyle),
                  SizedBox(height: 4.0),
                  Text(
                    '未出勤',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundBackgroundButton(
                  labelText: '出勤する',
                  labelColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  labelFontSize: 24.0,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  onPressed: () {},
                ),
                RoundBackgroundButton(
                  labelText: '退勤する',
                  labelColor: Colors.white,
                  backgroundColor: Colors.redAccent,
                  labelFontSize: 24.0,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
