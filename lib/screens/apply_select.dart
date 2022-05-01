import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/screens/apply_pto.dart';
import 'package:hatarakujikan_app/widgets/apply_list2.dart';

class ApplySelect extends StatelessWidget {
  final GroupModel? group;
  final UserModel? user;

  ApplySelect({this.group, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        elevation: 0.0,
        centerTitle: true,
        title: Text('申請する', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          ApplyList2(
            label: '勤怠修正の申請',
            subLabel: '※勤怠履歴から行うことができます。',
          ),
          ApplyList2(
            label: '有給休暇の申請',
            onTap: () => nextScreen(
              context,
              ApplyPTOScreen(group: group, user: user),
            ),
          ),
        ],
      ),
    );
  }
}
