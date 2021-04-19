import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hatarakujikan_app/helpers/dialog.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/user_work.dart';
import 'package:hatarakujikan_app/widgets/custom_work_area.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';

class WorkScreen extends StatefulWidget {
  final UserProvider userProvider;
  final UserWorkProvider userWorkProvider;

  WorkScreen({
    @required this.userProvider,
    @required this.userWorkProvider,
  });

  @override
  _WorkScreenState createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  GoogleMapController mapController;
  double _longitude;
  double _latitude;

  void _init() async {
    bool isGetLocation = await widget.userProvider.checkLocation();
    if (isGetLocation) {
      List<String> _location = await widget.userProvider.getLocation();
      if (_location != null) {
        setState(() {
          _longitude = double.parse(_location.first);
          _latitude = double.parse(_location.last);
        });
      }
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
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            height: double.infinity,
            child: _longitude != null && _latitude != null
                ? GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_latitude, _longitude),
                      zoom: 17.0,
                    ),
                    compassEnabled: false,
                    rotateGesturesEnabled: false,
                    tiltGesturesEnabled: false,
                    myLocationEnabled: true,
                  )
                : Loading(size: 32.0),
          ),
        ),
        CustomWorkArea(
          topLeft: widget.userProvider.user?.workId == '' &&
                  widget.userProvider.user?.breaksId == ''
              ? TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => WorkStartDialog(
                        userProvider: widget.userProvider,
                        userWorkProvider: widget.userWorkProvider,
                        longitude: _longitude,
                        latitude: _latitude,
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
          topRight: widget.userProvider.user?.workId != '' &&
                  widget.userProvider.user?.breaksId == ''
              ? TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => WorkEndDialog(
                        user: widget.userProvider.user,
                        userProvider: widget.userProvider,
                        userWorkProvider: widget.userWorkProvider,
                        longitude: _longitude,
                        latitude: _latitude,
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
          bottomLeft: widget.userProvider.user?.workId != '' &&
                  widget.userProvider.user?.breaksId == ''
              ? TextButton(
                  onPressed: () {},
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
          bottomRight: widget.userProvider.user?.workId != '' &&
                  widget.userProvider.user?.breaksId != ''
              ? TextButton(
                  onPressed: () {},
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
