import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/work.dart';
import 'package:hatarakujikan_app/screens/group_select.dart';
import 'package:hatarakujikan_app/screens/work_button.dart';
import 'package:hatarakujikan_app/widgets/custom_expanded_button.dart';
import 'package:hatarakujikan_app/widgets/error_list_tile.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';

class WorkScreen extends StatefulWidget {
  final UserProvider userProvider;
  final WorkProvider workProvider;

  WorkScreen({
    required this.userProvider,
    required this.workProvider,
  });

  @override
  _WorkScreenState createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  GoogleMapController? mapController;
  List<double> locations = [];
  bool error = false;
  String errorText = '';
  bool locationError = false;

  void _init() async {
    bool isGetLocation = await widget.userProvider.checkLocation();
    if (isGetLocation) {
      List<String> _locations = await widget.userProvider.getLocation();
      if (_locations.length != 0 && mounted) {
        setState(() {
          locations = [
            double.parse(_locations.first),
            double.parse(_locations.last),
          ];
          if (widget.userProvider.group!.areaSecurity == true) {
            if (!areaCheck(
              widget.userProvider.group!.areaLat,
              widget.userProvider.group!.areaLon,
              widget.userProvider.group!.areaRange,
              locations,
            )) {
              locationError = true;
            }
          }
        });
        if (widget.userProvider.group == null) {
          error = true;
          errorText = '会社/組織に所属していません';
        }
      }
      if (locations.length == 0) {
        error = true;
        errorText = '位置情報の取得に失敗しました';
      }
    } else {
      error = true;
      errorText = '位置情報の取得に失敗しました';
    }
  }

  Future<void> _future() async {
    List<String> _locations = await widget.userProvider.getLocation();
    if (_locations.length != 0 && mounted) {
      setState(() {
        locations = [
          double.parse(_locations.first),
          double.parse(_locations.last),
        ];
        if (widget.userProvider.group!.areaSecurity == true) {
          if (!areaCheck(
            widget.userProvider.group!.areaLat,
            widget.userProvider.group!.areaLon,
            widget.userProvider.group!.areaRange,
            locations,
          )) {
            locationError = true;
          }
        }
      });
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
                  GroupSelect(userProvider: widget.userProvider),
                ),
                backgroundColor: Colors.blueGrey,
                label: widget.userProvider.group!.name,
                color: Colors.white,
                leading: Icon(Icons.store, color: Colors.white),
                trailing: Icon(Icons.arrow_drop_down, color: Colors.white),
              )
            : Container(),
        Expanded(
          child: FutureBuilder(
            future: _future(),
            builder: (context, snapshot) {
              return Container(
                height: double.infinity,
                child: locations.length != 0
                    ? GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            locations.first,
                            locations.last,
                          ),
                          zoom: 17.0,
                        ),
                        circles: widget.userProvider.group != null
                            ? Set.from([
                                Circle(
                                  circleId: CircleId('area'),
                                  center: LatLng(
                                    widget.userProvider.group!.areaLat,
                                    widget.userProvider.group!.areaLon,
                                  ),
                                  radius: widget.userProvider.group!.areaRange,
                                  fillColor: Colors.red.withOpacity(0.3),
                                  strokeColor: Colors.transparent,
                                ),
                              ])
                            : Set<Circle>(),
                        compassEnabled: false,
                        rotateGesturesEnabled: false,
                        tiltGesturesEnabled: false,
                        myLocationEnabled: true,
                      )
                    : Loading(color: Colors.cyan),
              );
            },
          ),
        ),
        error
            ? ErrorListTile(label: errorText)
            : locationError
                ? ErrorListTile(label: '記録可能な範囲外にいます')
                : Container(),
        WorkButton(
          userProvider: widget.userProvider,
          workProvider: widget.workProvider,
          locations: locations,
          error: error,
          locationError: locationError,
        ),
      ],
    );
  }
}
