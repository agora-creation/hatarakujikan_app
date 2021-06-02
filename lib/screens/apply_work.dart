import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hatarakujikan_app/widgets/custom_datetime_button.dart';
import 'package:hatarakujikan_app/widgets/custom_icon_label.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';

class ApplyWorkScreen extends StatefulWidget {
  @override
  _ApplyWorkScreenState createState() => _ApplyWorkScreenState();
}

class _ApplyWorkScreenState extends State<ApplyWorkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue.shade100,
        elevation: 0.0,
        centerTitle: true,
        title: Text('記録修正申請', style: TextStyle(color: Colors.black54)),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: Icon(Icons.close, color: Colors.black54),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          CustomIconLabel(
            icon: Icon(Icons.run_circle, color: Colors.blue),
            labelText: '出勤時間',
          ),
          ListTile(
            leading: Text('修正前'),
            title: Text('2021/01/01 11:11'),
          ),
          ListTile(
            leading: Text('修正後'),
            title: CustomDatetimeButton(
              onTap: () {
                DatePicker.showDateTimePicker(
                  context,
                  showTitleActions: true,
                  locale: LocaleType.jp,
                  onChanged: (date) {},
                  onConfirm: (date) {},
                  currentTime: DateTime.now(),
                );
              },
              labelText: '2021/01/01 11:11',
            ),
          ),
          SizedBox(height: 8.0),
          CustomIconLabel(
            icon: Icon(Icons.run_circle, color: Colors.orange),
            labelText: '休憩開始時間',
          ),
          ListTile(
            leading: Text('修正前'),
            title: Text('2021/01/01 11:11'),
          ),
          ListTile(
            leading: Text('修正後'),
            title: CustomDatetimeButton(
              onTap: () {},
              labelText: '2021/01/01 11:11',
            ),
          ),
          SizedBox(height: 16.0),
          RoundBackgroundButton(
            onPressed: () {},
            labelText: '申請する',
            labelColor: Colors.black54,
            backgroundColor: Colors.blue.shade100,
          ),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }
}
