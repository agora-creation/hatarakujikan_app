import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';

class ApplyWorkScreen extends StatelessWidget {
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
            icon: Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          CustomTextFormField(
            controller: null,
            obscureText: false,
            textInputType: null,
            maxLines: 1,
            labelText: '出勤時間',
            labelColor: Colors.black54,
            prefixIconData: Icons.today,
            suffixIconData: null,
            onTap: null,
          ),
          SizedBox(height: 8.0),
          CustomTextFormField(
            controller: null,
            obscureText: false,
            textInputType: null,
            maxLines: 1,
            labelText: '休憩開始時間',
            labelColor: Colors.black54,
            prefixIconData: Icons.today,
            suffixIconData: null,
            onTap: null,
          ),
          SizedBox(height: 8.0),
          CustomTextFormField(
            controller: null,
            obscureText: false,
            textInputType: null,
            maxLines: 1,
            labelText: '休憩終了時間',
            labelColor: Colors.black54,
            prefixIconData: Icons.today,
            suffixIconData: null,
            onTap: null,
          ),
          SizedBox(height: 8.0),
          CustomTextFormField(
            controller: null,
            obscureText: false,
            textInputType: null,
            maxLines: 1,
            labelText: '退勤時間',
            labelColor: Colors.black54,
            prefixIconData: Icons.today,
            suffixIconData: null,
            onTap: null,
          ),
          SizedBox(height: 16.0),
          RoundBackgroundButton(
            onPressed: () {},
            labelText: '申請する',
            labelColor: Colors.white,
            backgroundColor: Colors.lightBlue,
          ),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }
}
