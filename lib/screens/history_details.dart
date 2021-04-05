import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';
import 'package:intl/intl.dart';

class HistoryDetailsScreen extends StatelessWidget {
  final DateTime day;

  HistoryDetailsScreen({@required this.day});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5F5),
        elevation: 0.0,
        centerTitle: true,
        title: Text('${DateFormat('yyyy年MM月dd日 (E)', 'ja').format(day)}'),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('保存'),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          Text('出勤時間'),
          Text('退勤時間'),
          SizedBox(height: 8.0),
          CustomTextFormField(
            controller: null,
            obscureText: false,
            textInputType: TextInputType.multiline,
            maxLines: null,
            labelText: 'メモ',
            prefixIconData: Icons.short_text,
            suffixIconData: null,
            onTap: null,
          ),
          SizedBox(height: 16.0),
          RoundBackgroundButton(
            labelText: '変更申請',
            labelColor: Colors.white,
            backgroundColor: Colors.blue,
            labelFontSize: 16.0,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            onPressed: () {},
          ),
          SizedBox(height: 8.0),
          RoundBackgroundButton(
            labelText: '削除申請',
            labelColor: Colors.white,
            backgroundColor: Colors.red,
            labelFontSize: 16.0,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
