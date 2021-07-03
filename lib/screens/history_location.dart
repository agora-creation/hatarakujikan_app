import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class HistoryLocationScreen extends StatefulWidget {
  final String title;
  final DateTime dateTime;
  final double lat;
  final double lon;

  HistoryLocationScreen({
    @required this.title,
    @required this.dateTime,
    @required this.lat,
    @required this.lon,
  });

  @override
  _HistoryLocationScreenState createState() => _HistoryLocationScreenState();
}

class _HistoryLocationScreenState extends State<HistoryLocationScreen> {
  GoogleMapController mapController;

  Set<Marker> _createMarker(double lat, double lon) {
    LatLng _position = LatLng(lat, lon);
    return {
      Marker(
        markerId: MarkerId('marker'),
        position: _position,
        infoWindow: InfoWindow(
          title: widget.title,
          snippet: '${DateFormat('yyyy/MM/dd HH:mm').format(widget.dateTime)}',
        ),
      ),
    };
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() => mapController = controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('記録した位置情報'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left, size: 32.0, color: Colors.black54),
        ),
      ),
      body: Container(
        height: double.infinity,
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _createMarker(widget.lat, widget.lon),
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.lat, widget.lon),
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
