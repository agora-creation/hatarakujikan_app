import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/work.dart';
import 'package:hatarakujikan_app/screens/work_button.dart';
import 'package:hatarakujikan_app/widgets/custom_expanded_button.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';

class WorkScreen extends StatefulWidget {
  final UserProvider userProvider;
  final WorkProvider workProvider;

  WorkScreen({
    @required this.userProvider,
    @required this.workProvider,
  });

  @override
  _WorkScreenState createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  GoogleMapController mapController;
  List<double> locations;
  String error = '';

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
      if (locations == null) {
        error = '位置情報の取得に失敗しました';
      }
    } else {
      error = '位置情報の取得に失敗しました';
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
          onTap: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => GroupsDialog(
                groups: widget.userProvider.groups,
              ),
            );
          },
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
        error != ''
            ? CustomExpandedButton(
                buttonColor: Colors.redAccent,
                labelText: '位置情報の取得に失敗しました',
                labelColor: Colors.white,
                leadingIcon: Icon(Icons.error, color: Colors.white),
                trailingIcon: null,
                onTap: null,
              )
            : Container(),
        WorkButton(
          userProvider: widget.userProvider,
          workProvider: widget.workProvider,
          locations: locations,
        ),
      ],
    );
  }
}

class GroupsDialog extends StatefulWidget {
  final List<GroupModel> groups;

  GroupsDialog({@required this.groups});

  @override
  _GroupsDialogState createState() => _GroupsDialogState();
}

class _GroupsDialogState extends State<GroupsDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '会社/組織 切替',
        style: TextStyle(fontSize: 18.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('キャンセル', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(backgroundColor: Colors.grey),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('はい', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
