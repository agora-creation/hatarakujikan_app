import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/work.dart';
import 'package:hatarakujikan_app/screens/group_select.dart';
import 'package:hatarakujikan_app/widgets/custom_google_map.dart';
import 'package:hatarakujikan_app/widgets/error_list_tile.dart';
import 'package:hatarakujikan_app/widgets/expanded_button.dart';
import 'package:hatarakujikan_app/widgets/work_buttons.dart';

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

  void _onMapCreated(GoogleMapController controller) {
    setState(() => mapController = controller);
  }

  @override
  Widget build(BuildContext context) {
    GroupModel? _group = widget.userProvider.group;

    return FutureBuilder<List<double>>(
      future: widget.userProvider.futureLocation(),
      builder: (context, snapshot) {
        List<double>? _locations = snapshot.data;
        bool _error = false;
        String _errorText = '';
        bool _locationError = false;
        if (_locations?.length == 0) {
          _error = true;
          _errorText = '位置情報の取得に失敗しました';
        }
        if (_group == null) {
          _error = true;
          _errorText = '会社/組織に所属していません';
        }
        if (_group?.areaSecurity == true) {
          if (!areaCheck(
            areaLat: _group?.areaLat ?? 0,
            areaLon: _group?.areaLon ?? 0,
            areaRange: _group?.areaRange ?? 0,
            locations: _locations ?? [],
          )) {
            _locationError = true;
          }
        }
        return Column(
          children: [
            _group != null
                ? ExpandedButton(
                    onTap: () => overlayScreen(
                      context,
                      GroupSelect(userProvider: widget.userProvider),
                    ),
                    backgroundColor: Colors.blueGrey,
                    label: _group.name,
                    color: Colors.white,
                    leading: Icon(Icons.store, color: Colors.white),
                    trailing: Icon(Icons.arrow_drop_down, color: Colors.white),
                  )
                : Container(),
            CustomGoogleMap(
              locations: _locations ?? [],
              onMapCreated: _onMapCreated,
              group: _group,
            ),
            _error == true
                ? ErrorListTile(_errorText)
                : _locationError == true
                    ? ErrorListTile('記録可能な範囲外にいます')
                    : Container(),
            WorkButtons(
              userProvider: widget.userProvider,
              workProvider: widget.workProvider,
              locations: _locations ?? [],
              error: _error,
              locationError: _locationError,
            ),
          ],
        );
      },
    );
  }
}
