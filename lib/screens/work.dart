import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/work.dart';
import 'package:hatarakujikan_app/screens/group_select.dart';
import 'package:hatarakujikan_app/screens/work_button.dart';
import 'package:hatarakujikan_app/widgets/custom_expanded_button.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';

class WorkScreen extends StatefulWidget {
  final UserProvider userProvider;
  final WorkProvider workProvider;
  final String groupId;

  WorkScreen({
    @required this.userProvider,
    @required this.workProvider,
    @required this.groupId,
  });

  @override
  _WorkScreenState createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  GoogleMapController mapController;
  List<double> locations;
  bool workError = false;
  String workErrorText = '';

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
        if (widget.userProvider.group == null) {
          workError = true;
          workErrorText = '会社/組織に所属していません';
        }
      }
      if (locations == null) {
        workError = true;
        workErrorText = '位置情報の取得に失敗しました';
      }
    } else {
      workError = true;
      workErrorText = '位置情報の取得に失敗しました';
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() => mapController = controller);
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
        widget.userProvider.group != null
            ? CustomExpandedButton(
                onTap: () => overlayScreen(
                  context,
                  GroupSelect(
                    userProvider: widget.userProvider,
                    groupId: widget.groupId,
                  ),
                ),
                buttonColor: Colors.blueGrey,
                labelText: widget.userProvider.group?.name,
                labelColor: Colors.white,
                leadingIcon: Icon(Icons.store, color: Colors.white),
                trailingIcon: Icon(Icons.arrow_drop_down, color: Colors.white),
              )
            : Container(),
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
                : Loading(color: Colors.cyan),
          ),
        ),
        workError
            ? ListTile(
                tileColor: Colors.redAccent,
                title: Text(
                  workErrorText,
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
              )
            : Container(),
        WorkButton(
          userProvider: widget.userProvider,
          workProvider: widget.workProvider,
          locations: locations,
          workError: workError,
        ),
      ],
    );
  }
}
