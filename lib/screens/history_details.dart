import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/breaks.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/screens/apply_work.dart';
import 'package:hatarakujikan_app/screens/history_location.dart';
import 'package:hatarakujikan_app/widgets/custom_list_tile.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';

class HistoryDetailsScreen extends StatelessWidget {
  final WorkModel work;

  HistoryDetailsScreen({required this.work});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text(dateText('yyyy年MM月dd日 (E)', work.startedAt)),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: 32.0, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          Text('記録した時間'),
          SizedBox(height: 8.0),
          Divider(height: 1.0, color: Colors.grey),
          CustomListTile(
            label: '勤務状況',
            value: work.state,
          ),
          CustomListTile(
            icon: work.startedLat == 0 || work.startedLon == 0
                ? Icon(Icons.location_off)
                : Icon(Icons.location_on),
            label: '出勤時間',
            value: work.startTime(),
          ),
          CustomListTile(
            icon: work.endedLat == 0 || work.endedLon == 0
                ? Icon(Icons.location_off)
                : Icon(Icons.location_on),
            label: '退勤時間',
            value: work.endTime(),
          ),
          work.breaks.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: work.breaks.length,
                  itemBuilder: (_, index) {
                    BreaksModel _breaks = work.breaks[index];
                    return Column(
                      children: [
                        CustomListTile(
                          icon:
                              _breaks.startedLat == 0 || _breaks.startedLon == 0
                                  ? Icon(Icons.location_off)
                                  : Icon(Icons.location_on),
                          label: '休憩開始時間',
                          value: _breaks.startTime(),
                        ),
                        CustomListTile(
                          icon: _breaks.endedLat == 0 || _breaks.endedLon == 0
                              ? Icon(Icons.location_off)
                              : Icon(Icons.location_on),
                          label: '休憩終了時間',
                          value: _breaks.endTime(),
                        ),
                      ],
                    );
                  },
                )
              : Container(),
          CustomListTile(
            label: '勤務時間',
            value: work.workTime(),
          ),
          SizedBox(height: 16.0),
          RoundBackgroundButton(
            label: '位置情報を確認',
            color: Colors.black54,
            backgroundColor: Colors.green.shade100,
            onPressed: () => nextScreen(
              context,
              HistoryLocationScreen(work: work),
            ),
          ),
          SizedBox(height: 8.0),
          RoundBackgroundButton(
            label: '勤怠修正の申請',
            color: Colors.black54,
            backgroundColor: Colors.blue.shade100,
            onPressed: () => overlayScreen(
              context,
              ApplyWorkScreen(work: work),
            ),
          ),
        ],
      ),
    );
  }
}
