import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/apply_work.dart';
import 'package:hatarakujikan_app/models/breaks.dart';
import 'package:hatarakujikan_app/providers/apply_work.dart';
import 'package:hatarakujikan_app/widgets/custom_column.dart';
import 'package:hatarakujikan_app/widgets/round_border_button.dart';

class ApplyWorkDetailsScreen extends StatelessWidget {
  final ApplyWorkProvider applyWorkProvider;
  final ApplyWorkModel applyWork;

  ApplyWorkDetailsScreen({
    required this.applyWorkProvider,
    required this.applyWork,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade100,
        elevation: 0.0,
        centerTitle: true,
        title: Text('勤怠修正の申請', style: TextStyle(color: Colors.black54)),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: 32.0, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          Text('申請内容をご確認ください。'),
          SizedBox(height: 16.0),
          CustomColumn(
            label: '申請日時',
            value: dateText('yyyy/MM/dd HH:mm', applyWork.createdAt),
          ),
          CustomColumn(
            label: '出勤日時',
            value: dateText('yyyy/MM/dd HH:mm', applyWork.startedAt),
          ),
          CustomColumn(
            label: '退勤日時',
            value: dateText('yyyy/MM/dd HH:mm', applyWork.endedAt),
          ),
          applyWork.breaks.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: applyWork.breaks.length,
                  itemBuilder: (_, index) {
                    BreaksModel _breaks = applyWork.breaks[index];
                    return Column(
                      children: [
                        CustomColumn(
                          label: '休憩開始日時',
                          value: dateText(
                            'yyyy/MM/dd HH:mm',
                            _breaks.startedAt,
                          ),
                        ),
                        CustomColumn(
                          label: '休憩終了日時',
                          value: dateText(
                            'yyyy/MM/dd HH:mm',
                            _breaks.endedAt,
                          ),
                        ),
                      ],
                    );
                  },
                )
              : Container(),
          CustomColumn(
            label: '事由',
            value: applyWork.reason,
          ),
          SizedBox(height: 16.0),
          RoundBorderButton(
            label: '申請を取り消す',
            color: Colors.red,
            borderColor: Colors.red,
            onPressed: () {
              applyWorkProvider.delete(id: applyWork.id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
