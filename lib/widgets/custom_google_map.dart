import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';

class CustomGoogleMap extends StatelessWidget {
  final List<double> locations;
  final Function(GoogleMapController)? onMapCreated;
  final GroupModel? group;

  CustomGoogleMap({
    required this.locations,
    this.onMapCreated,
    this.group,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: double.infinity,
        child: locations.length == 0
            ? Loading(color: Colors.cyan)
            : GoogleMap(
                onMapCreated: onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    locations.first,
                    locations.last,
                  ),
                  zoom: 17.0,
                ),
                circles: group != null
                    ? Set.from([
                        Circle(
                          circleId: CircleId('area'),
                          center: LatLng(
                            group?.areaLat ?? 0,
                            group?.areaLon ?? 0,
                          ),
                          radius: group?.areaRange ?? 0,
                          fillColor: Colors.red.withOpacity(0.3),
                          strokeColor: Colors.transparent,
                        ),
                      ])
                    : Set<Circle>(),
                compassEnabled: false,
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
                myLocationEnabled: true,
              ),
      ),
    );
  }
}
