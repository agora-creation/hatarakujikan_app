import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/apply_work.dart';
import 'package:hatarakujikan_app/models/breaks.dart';
import 'package:hatarakujikan_app/providers/apply_work.dart';
import 'package:hatarakujikan_app/widgets/custom_apply_work_list_tile.dart';
import 'package:hatarakujikan_app/widgets/round_border_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ApplyWorkDetailsScreen extends StatelessWidget {
  final ApplyWorkModel applyWork;

  ApplyWorkDetailsScreen({@required this.applyWork});

  @override
  Widget build(BuildContext context) {
    final applyWorkProvider = Provider.of<ApplyWorkProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        elevation: 0.0,
        centerTitle: true,
        title: Text('記録修正申請', style: TextStyle(color: Colors.black54)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left, size: 32.0, color: Colors.black54),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          Text('申請内容をご確認ください。'),
          SizedBox(height: 16.0),
          CustomApplyWorkListTile(
            label: '申請日時',
            value: '${DateFormat(formatYMDHM).format(applyWork.createdAt)}',
          ),
          CustomApplyWorkListTile(
            label: '出勤時間',
            value: '${DateFormat(formatYMDHM).format(applyWork.startedAt)}',
          ),
          applyWork.breaks.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: applyWork.breaks.length,
                  itemBuilder: (_, index) {
                    BreaksModel _breaks = applyWork.breaks[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomApplyWorkListTile(
                          label: '休憩開始時間',
                          value:
                              '${DateFormat(formatYMDHM).format(_breaks.startedAt)}',
                        ),
                        CustomApplyWorkListTile(
                          label: '休憩終了時間',
                          value:
                              '${DateFormat(formatYMDHM).format(_breaks.endedAt)}',
                        ),
                      ],
                    );
                  },
                )
              : Container(),
          CustomApplyWorkListTile(
            label: '退勤時間',
            value: '${DateFormat(formatYMDHM).format(applyWork.endedAt)}',
          ),
          SizedBox(height: 16.0),
          RoundBorderButton(
            onPressed: () {
              applyWorkProvider.delete(applyWork: applyWork);
              Navigator.pop(context);
            },
            labelText: '申請を取り消す',
            labelColor: Colors.red,
            borderColor: Colors.red,
          ),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }
}