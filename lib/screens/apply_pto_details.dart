import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/apply_pto.dart';
import 'package:hatarakujikan_app/providers/apply_pto.dart';
import 'package:hatarakujikan_app/widgets/custom_column.dart';
import 'package:hatarakujikan_app/widgets/round_border_button.dart';

class ApplyPTODetailsScreen extends StatelessWidget {
  final ApplyPTOProvider applyPTOProvider;
  final ApplyPTOModel applyPTO;

  ApplyPTODetailsScreen({
    required this.applyPTOProvider,
    required this.applyPTO,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade100,
        elevation: 0.0,
        centerTitle: true,
        title: Text('有給休暇の申請', style: TextStyle(color: Colors.black54)),
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
            value: dateText('yyyy/MM/dd HH:mm', applyPTO.createdAt),
          ),
          CustomColumn(
            label: '開始日',
            value: dateText('yyyy/MM/dd', applyPTO.startedAt),
          ),
          CustomColumn(
            label: '終了日',
            value: dateText('yyyy/MM/dd', applyPTO.endedAt),
          ),
          CustomColumn(
            label: '事由',
            value: applyPTO.reason,
          ),
          SizedBox(height: 16.0),
          RoundBorderButton(
            label: '申請を取り消す',
            color: Colors.red,
            borderColor: Colors.red,
            onPressed: () {
              applyPTOProvider.delete(id: applyPTO.id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
