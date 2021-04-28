import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/user_work.dart';
import 'package:hatarakujikan_app/screens/work_button.dart';
import 'package:hatarakujikan_app/widgets/custom_expanded_button.dart';
import 'package:hatarakujikan_app/widgets/error_message.dart';
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
  List<double> locations;

  void _init() async {
    bool isGetLocation = await widget.userProvider.checkLocation();
    if (isGetLocation) {
      List<String> _locations = await widget.userProvider.getLocation();
      if (_locations != null) {
        setState(() {
          locations = [
            double.parse(_locations.first),
            double.parse(_locations.last),
          ];
        });
      }
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => ErrorMessage(
          message: '位置情報の取得に失敗しました。お使いのスマートフォンの設定から位置情報の取得を許可してください。',
        ),
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
        CustomExpandedButton(
          buttonColor: Colors.blueGrey,
          labelText: '会社/組織 所属なし',
          labelColor: Colors.white,
          leadingIcon: Icon(Icons.store, color: Colors.white),
          trailingIcon: Icon(Icons.arrow_drop_down, color: Colors.white),
          onTap: () {},
        ),
        Expanded(
          child: Container(
            height: double.infinity,
            child: locations != null
                ? GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(locations.first, locations.last),
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
        WorkButton(
          userProvider: widget.userProvider,
          userWorkProvider: widget.userWorkProvider,
          locations: locations,
        ),
      ],
    );
  }
}
