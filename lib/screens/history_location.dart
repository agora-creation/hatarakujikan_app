import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/work.dart';

class HistoryLocationScreen extends StatefulWidget {
  final WorkModel work;

  HistoryLocationScreen({required this.work});

  @override
  _HistoryLocationScreenState createState() => _HistoryLocationScreenState();
}

class _HistoryLocationScreenState extends State<HistoryLocationScreen> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};

  void _init() async {
    if (mounted) {
      setState(() {
        markers.add(Marker(
          markerId: MarkerId('start_${widget.work.id}'),
          position: LatLng(
            widget.work.startedLat,
            widget.work.startedLon,
          ),
          infoWindow: InfoWindow(
            title: '出勤日時',
            snippet: dateText('yyyy/MM/dd HH:mm', widget.work.startedAt),
          ),
        ));
        markers.add(Marker(
          markerId: MarkerId('end_${widget.work.id}'),
          position: LatLng(
            widget.work.endedLat,
            widget.work.endedLon,
          ),
          infoWindow: InfoWindow(
            title: '退勤日時',
            snippet: dateText('yyyy/MM/dd HH:mm', widget.work.endedAt),
          ),
        ));
        widget.work.breaks.forEach((e) {
          markers.add(Marker(
            markerId: MarkerId('breakStart_${e.id}'),
            position: LatLng(
              e.startedLat,
              e.startedLon,
            ),
            infoWindow: InfoWindow(
              title: '休憩開始日時',
              snippet: dateText('yyyy/MM/dd HH:mm', e.startedAt),
            ),
          ));
          markers.add(Marker(
            markerId: MarkerId('breakEnd_${e.id}'),
            position: LatLng(
              e.endedLat,
              e.endedLon,
            ),
            infoWindow: InfoWindow(
              title: '休憩終了日時',
              snippet: dateText('yyyy/MM/dd HH:mm', e.endedAt),
            ),
          ));
        });
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        elevation: 0.0,
        centerTitle: true,
        title: Text('位置情報を確認'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: 32.0, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        height: double.infinity,
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: markers,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.work.startedLat,
              widget.work.startedLon,
            ),
            zoom: 17.0,
          ),
          compassEnabled: false,
          rotateGesturesEnabled: false,
          tiltGesturesEnabled: false,
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
        ),
      ),
    );
  }
}
