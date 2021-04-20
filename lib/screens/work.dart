import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hatarakujikan_app/helpers/dialog.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/user_work.dart';
import 'package:hatarakujikan_app/widgets/custom_work_button.dart';
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
        CustomWorkButton(
          userProvider: widget.userProvider,
          userWorkProvider: widget.userWorkProvider,
          latitude: _latitude,
          longitude: _longitude,
        ),
      ],
    );
  }
}
