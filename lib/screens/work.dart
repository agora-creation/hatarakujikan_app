import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hatarakujikan_app/helpers/dialog.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/user_work.dart';
import 'package:hatarakujikan_app/widgets/custom_work_area.dart';
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
  GoogleMapController mapController;
  List<String> _location;
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

  void _checkLocation() async {
    bool isGetLocation = await widget.userProvider.checkLocation();
    if (isGetLocation) {
      _location = await widget.userProvider.getLocation();
    } else {
      showDialog(
        context: context,
        builder: (_) => LocationDialog(),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  void initState() {
    super.initState();
    // Timer.periodic(Duration(seconds: 1), _onTimer);
    _checkLocation();
  }

  @override
  Widget build(BuildContext context) {
    final double _deviceWidth = MediaQuery.of(context).size.width;
    Color _workStatusColor = Colors.grey;
    if (widget.user?.workId == '' && widget.user?.breaksId == '') {
      _workStatusColor = Colors.grey;
    } else if (widget.user?.workId != '' && widget.user?.breaksId == '') {
      _workStatusColor = Colors.blue;
    } else if (widget.user?.workId != '' && widget.user?.breaksId != '') {
      _workStatusColor = Colors.orange;
    }

    return Column(
      children: [
        Expanded(
          child: Container(
            height: double.infinity,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(33.558271, 133.551724),
                zoom: 17.0,
              ),
              compassEnabled: false,
              rotateGesturesEnabled: false,
              tiltGesturesEnabled: false,
              myLocationEnabled: true,
            ),

            // Center(
            //   child: SingleChildScrollView(
            //     padding: EdgeInsets.symmetric(horizontal: 24.0),
            //     child: Container(
            //       width: _deviceWidth,
            //       height: _deviceWidth,
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         border: Border.all(color: _workStatusColor, width: 8.0),
            //         color: _workStatusColor.withOpacity(0.3),
            //       ),
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Text(_date, style: kDateTextStyle),
            //           Text(_time, style: kTimeTextStyle),
            //           SizedBox(height: 8.0),
            //           Text(
            //             _location,
            //             style: TextStyle(
            //               color: Colors.black38,
            //               fontSize: 16.0,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ),
        ),
        CustomWorkArea(
          topLeft: widget.user?.workId == '' && widget.user?.breaksId == ''
              ? TextButton(
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
                  child: Text(
                    '出勤',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    padding: EdgeInsets.all(16.0),
                  ),
                )
              : TextButton(
                  onPressed: null,
                  child: Text(
                    '出勤',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    padding: EdgeInsets.all(16.0),
                  ),
                ),
          topRight: widget.user?.workId != '' && widget.user?.breaksId == ''
              ? TextButton(
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
                  child: Text(
                    '退勤',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    padding: EdgeInsets.all(16.0),
                  ),
                )
              : TextButton(
                  onPressed: null,
                  child: Text(
                    '退勤',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    padding: EdgeInsets.all(16.0),
                  ),
                ),
          bottomLeft: widget.user?.workId != '' && widget.user?.breaksId == ''
              ? TextButton(
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
                  child: Text(
                    '休憩開始',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    padding: EdgeInsets.all(16.0),
                  ),
                )
              : TextButton(
                  onPressed: null,
                  child: Text(
                    '休憩開始',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    padding: EdgeInsets.all(16.0),
                  ),
                ),
          bottomRight: widget.user?.workId != '' && widget.user?.breaksId != ''
              ? TextButton(
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
                  child: Text(
                    '休憩終了',
                    style: TextStyle(color: Colors.orange, fontSize: 16.0),
                  ),
                  style: TextButton.styleFrom(
                    side: BorderSide(color: Colors.orange, width: 1),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    padding: EdgeInsets.all(16.0),
                  ),
                )
              : TextButton(
                  onPressed: null,
                  child: Text(
                    '休憩終了',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    padding: EdgeInsets.all(16.0),
                  ),
                ),
        ),
      ],
    );
  }
}
