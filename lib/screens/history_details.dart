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
            onTap: null,
            icon: null,
            label: '勤務状況',
            subtitle: null,
            time: '${work.state}',
          ),
          work.startedLat != 0.0 || work.startedLon != 0.0
              ? CustomHistoryDetailsListTile(
                  onTap: () => nextScreen(
                    context,
                    HistoryLocationScreen(
                      title: '出勤時間',
                      dateTime: work.startedAt,
                      lat: work.startedLat,
                      lon: work.startedLon,
                    ),
                  ),
                  icon: Icon(Icons.location_on),
                  label: '出勤時間',
                  subtitle: Text('位置情報を確認できます'),
                  time: work.startTime(),
                )
              : CustomHistoryDetailsListTile(
                  onTap: null,
                  icon: Icon(Icons.location_off),
                  label: '出勤時間',
                  subtitle: null,
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
                        _breaks.startedLat != 0.0 || _breaks.startedLon != 0.0
                            ? CustomHistoryDetailsListTile(
                                onTap: () => nextScreen(
                                  context,
                                  HistoryLocationScreen(
                                    title: '休憩開始時間',
                                    dateTime: _breaks.startedAt,
                                    lat: _breaks.startedLat,
                                    lon: _breaks.startedLon,
                                  ),
                                ),
                                icon: Icon(Icons.location_on),
                                label: '休憩開始時間',
                                subtitle: Text('位置情報を確認できます'),
                                time: _breaks.startTime(),
                              )
                            : CustomHistoryDetailsListTile(
                                onTap: null,
                                icon: Icon(Icons.location_off),
                                label: '休憩開始時間',
                                subtitle: null,
                                time: _breaks.startTime(),
                              ),
                        _breaks.startedLat != 0.0 || _breaks.startedLon != 0.0
                            ? CustomHistoryDetailsListTile(
                                onTap: () => nextScreen(
                                  context,
                                  HistoryLocationScreen(
                                    title: '休憩終了時間',
                                    dateTime: _breaks.endedAt,
                                    lat: _breaks.endedLat,
                                    lon: _breaks.endedLon,
                                  ),
                                ),
                                icon: Icon(Icons.location_on),
                                label: '休憩終了時間',
                                subtitle: Text('位置情報を確認できます'),
                                time: _breaks.endTime(),
                              )
                            : CustomHistoryDetailsListTile(
                                onTap: null,
                                icon: Icon(Icons.location_off),
                                label: '休憩終了時間',
                                subtitle: null,
                                time: _breaks.endTime(),
                              ),
                      ],
                    );
                  },
                )
              : Container(),
          work.endedLat != 0.0 || work.endedLon != 0.0
              ? CustomHistoryDetailsListTile(
                  onTap: () => nextScreen(
                    context,
                    HistoryLocationScreen(
                      title: '退勤時間',
                      dateTime: work.endedAt,
                      lat: work.endedLat,
                      lon: work.endedLon,
                    ),
                  ),
                  icon: Icon(Icons.location_on),
                  label: '退勤時間',
                  subtitle: Text('位置情報を確認できます'),
                  time: work.endTime(),
                )
              : CustomHistoryDetailsListTile(
                  onTap: null,
                  icon: Icon(Icons.location_off),
                  label: '退勤時間',
                  subtitle: null,
                  time: work.endTime(),
                ),
          CustomHistoryDetailsListTile(
            onTap: null,
            icon: null,
            label: '勤務時間',
            subtitle: null,
            time: '${work.workTime()}',
          ),
          SizedBox(height: 16.0),
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
