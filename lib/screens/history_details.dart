import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/breaks.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/screens/apply_work.dart';
import 'package:hatarakujikan_app/screens/history_location.dart';
import 'package:hatarakujikan_app/widgets/custom_history_details_list_tile.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';
import 'package:intl/intl.dart';

class HistoryDetailsScreen extends StatelessWidget {
  final WorkModel work;
  final UserModel user;

  HistoryDetailsScreen({
    @required this.work,
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          '${DateFormat('yyyy年MM月dd日 (E)', 'ja').format(work.startedAt)}',
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left, size: 32.0, color: Colors.black54),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          Text('記録した時間'),
          SizedBox(height: 8.0),
          Divider(height: 1.0, color: Colors.grey),
          CustomHistoryDetailsListTile(
            icon: null,
            label: '勤務状況',
            time: '${work.state}',
          ),
          CustomHistoryDetailsListTile(
            icon: work.startedLat != 0.0 || work.startedLon != 0.0
                ? Icon(Icons.location_on)
                : Icon(Icons.location_off),
            label: '出勤時間',
            time: work.startTime(),
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
                        CustomHistoryDetailsListTile(
                          icon: _breaks.startedLat != 0.0 ||
                                  _breaks.startedLon != 0.0
                              ? Icon(Icons.location_on)
                              : Icon(Icons.location_off),
                          label: '休憩開始時間',
                          time: _breaks.startTime(),
                        ),
                        CustomHistoryDetailsListTile(
                          icon:
                              _breaks.endedLat != 0.0 || _breaks.endedLon != 0.0
                                  ? Icon(Icons.location_on)
                                  : Icon(Icons.location_off),
                          label: '休憩終了時間',
                          time: _breaks.endTime(),
                        ),
                      ],
                    );
                  },
                )
              : Container(),
          CustomHistoryDetailsListTile(
            icon: work.endedLat != 0.0 || work.endedLon != 0.0
                ? Icon(Icons.location_on)
                : Icon(Icons.location_off),
            label: '退勤時間',
            time: work.endTime(),
          ),
          CustomHistoryDetailsListTile(
            icon: null,
            label: '勤務時間',
            time: work.workTime(),
          ),
          SizedBox(height: 16.0),
          RoundBackgroundButton(
            onPressed: () => nextScreen(
              context,
              HistoryLocationScreen(work: work),
            ),
            label: '位置情報を確認',
            color: Colors.black54,
            backgroundColor: Colors.green.shade100,
          ),
          SizedBox(height: 8.0),
          RoundBackgroundButton(
            onPressed: () => overlayScreen(
              context,
              ApplyWorkScreen(work: work, user: user),
            ),
            label: '記録修正申請',
            color: Colors.black54,
            backgroundColor: Colors.blue.shade100,
          ),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }
}
