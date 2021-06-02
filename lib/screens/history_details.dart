import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/breaks.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/screens/apply_work.dart';
import 'package:hatarakujikan_app/widgets/custom_history_details_list_tile.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';
import 'package:intl/intl.dart';

class HistoryDetailsScreen extends StatefulWidget {
  final WorkModel work;

  HistoryDetailsScreen({@required this.work});

  @override
  _HistoryDetailsScreenState createState() => _HistoryDetailsScreenState();
}

class _HistoryDetailsScreenState extends State<HistoryDetailsScreen> {
  GoogleMapController mapController;

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
        title: Text(
          '${DateFormat('yyyy年MM月dd日 (E)', 'ja').format(widget.work.startedAt)}',
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left, size: 32.0, color: Colors.black54),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          SizedBox(height: 16.0),
          Text('記録した時間'),
          SizedBox(height: 8.0),
          Divider(height: 1.0, color: Colors.grey),
          CustomHistoryDetailsListTile(
            icon: Icon(Icons.run_circle, color: Colors.blue),
            title: '出勤時間',
            time: '${DateFormat('HH:mm').format(widget.work.startedAt)}',
          ),
          widget.work.breaks.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: widget.work.breaks.length,
                  itemBuilder: (_, index) {
                    BreaksModel _breaks = widget.work.breaks[index];
                    return Column(
                      children: [
                        CustomHistoryDetailsListTile(
                          icon: Icon(Icons.run_circle, color: Colors.orange),
                          title: '休憩開始時間',
                          time:
                              '${DateFormat('HH:mm').format(_breaks.startedAt)}',
                        ),
                        CustomHistoryDetailsListTile(
                          icon: Icon(Icons.run_circle_outlined,
                              color: Colors.orange),
                          title: '休憩終了時間',
                          time:
                              '${DateFormat('HH:mm').format(_breaks.endedAt)}',
                        ),
                      ],
                    );
                  },
                )
              : Container(),
          CustomHistoryDetailsListTile(
            icon: Icon(Icons.run_circle, color: Colors.red),
            title: '退勤時間',
            time: '${DateFormat('HH:mm').format(widget.work.endedAt)}',
          ),
          CustomHistoryDetailsListTile(
            icon: null,
            title: '勤務時間',
            time: '${widget.work.workTime()}',
          ),
          SizedBox(height: 16.0),
          Container(
            height: 250.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
            ),
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.work.startedLat, widget.work.startedLon),
                zoom: 17.0,
              ),
              compassEnabled: false,
              rotateGesturesEnabled: false,
              scrollGesturesEnabled: false,
              zoomControlsEnabled: false,
              tiltGesturesEnabled: false,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
            ),
          ),
          SizedBox(height: 16.0),
          RoundBackgroundButton(
            onPressed: () => overlayScreen(context, ApplyWorkScreen()),
            labelText: '記録修正申請',
            labelColor: Colors.white,
            backgroundColor: Colors.lightBlue,
          ),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }
}
