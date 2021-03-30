import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/dialog.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/user_work.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';
import 'package:hatarakujikan_app/widgets/round_border_button.dart';
import 'package:intl/intl.dart';

class WorkScreen extends StatefulWidget {
  final UserModel user;
  final UserProvider userProvider;
  final UserWorkProvider userWorkProvider;

  WorkScreen({
    @required this.user,
    @required this.userProvider,
    @required this.userWorkProvider,
  });

  @override
  _WorkScreenState createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  String date = '';
  String time = '';
  String address = '現在地取得';

  void _onTimer(Timer timer) {
    var _now = DateTime.now();
    var _dateText = DateFormat('yyyy/MM/dd (E)', 'ja').format(_now);
    var _timeText = DateFormat('HH:mm:ss').format(_now);
    if (mounted) {
      setState(() {
        date = _dateText;
        time = _timeText;
      });
    }
  }

  void _checkLocation() async {
    bool isGetLocation = await widget.userProvider.checkLocation();
    if (isGetLocation) {
      address = await widget.userProvider.getLocation();
    } else {
      showDialog(
        context: context,
        builder: (_) => LocationDialog(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), _onTimer);
    _checkLocation();
  }

  @override
  Widget build(BuildContext context) {
    final double _deviceWidth = MediaQuery.of(context).size.width;
    String _workStatus = '';
    Color _workStatusColor = Colors.grey;
    if (widget.user?.workId == '' && widget.user?.workBreakId == '') {
      _workStatus = '未出勤';
      _workStatusColor = Colors.grey;
    } else if (widget.user?.workId != '' && widget.user?.workBreakId == '') {
      _workStatus = '出勤中';
      _workStatusColor = Colors.blueAccent;
    } else if (widget.user?.workId != '' && widget.user?.workBreakId != '') {
      _workStatus = '休憩中';
      _workStatusColor = Colors.orangeAccent;
    }

    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton.icon(
                onPressed: () => _checkLocation(),
                icon: Icon(Icons.location_pin, color: Colors.white),
                label: Text(address, style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent),
              ),
            ),
            Container(
              width: _deviceWidth,
              height: _deviceWidth,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _workStatusColor,
                  width: 8.0,
                ),
                color: _workStatusColor.withOpacity(0.3),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(date, style: kDateTextStyle),
                  Text(time, style: kTimeTextStyle),
                  SizedBox(height: 8.0),
                  Text(
                    _workStatus,
                    style: TextStyle(
                      color: _workStatusColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                widget.user?.workId == '' && widget.user?.workBreakId == ''
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
                                user: widget.user,
                                userProvider: widget.userProvider,
                                userWorkProvider: widget.userWorkProvider,
                              ),
                            );
                          },
                        ),
                      )
                    : Container(),
                widget.user?.workId != '' && widget.user?.workBreakId == ''
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
                                user: widget.user,
                                userProvider: widget.userProvider,
                                userWorkProvider: widget.userWorkProvider,
                              ),
                            );
                          },
                        ),
                      )
                    : Container(),
                widget.user?.workId != '' && widget.user?.workBreakId == ''
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
                                user: widget.user,
                                userProvider: widget.userProvider,
                                userWorkProvider: widget.userWorkProvider,
                              ),
                            );
                          },
                        ),
                      )
                    : Container(),
                widget.user?.workId != '' && widget.user?.workBreakId != ''
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
                                user: widget.user,
                                userProvider: widget.userProvider,
                                userWorkProvider: widget.userWorkProvider,
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
