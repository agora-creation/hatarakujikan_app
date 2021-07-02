import 'package:flutter/material.dart';
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
            value:
                '${DateFormat('yyyy/MM/dd HH:mm').format(applyWork.createdAt)}',
          ),
          CustomApplyWorkListTile(
            label: '出勤日時',
            value:
                '${DateFormat('yyyy/MM/dd HH:mm').format(applyWork.startedAt)}',
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
                          label: '休憩開始日時',
                          value:
                              '${DateFormat('yyyy/MM/dd HH:mm').format(_breaks.startedAt)}',
                        ),
                        CustomApplyWorkListTile(
                          label: '休憩終了日時',
                          value:
                              '${DateFormat('yyyy/MM/dd HH:mm').format(_breaks.endedAt)}',
                        ),
                      ],
                    );
                  },
                )
              : Container(),
          CustomApplyWorkListTile(
            label: '退勤日時',
            value:
                '${DateFormat('yyyy/MM/dd HH:mm').format(applyWork.endedAt)}',
          ),
          CustomApplyWorkListTile(
            label: '事由',
            value: '${applyWork.reason}',
          ),
          SizedBox(height: 16.0),
          RoundBorderButton(
            onPressed: () {
              applyWorkProvider.delete(applyWork: applyWork);
              Navigator.pop(context);
            },
            label: '申請を取り消す',
            color: Colors.red,
            borderColor: Colors.red,
          ),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }
}
