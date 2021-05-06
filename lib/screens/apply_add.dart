import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/widgets/custom_setting_list_tile.dart';

class ApplyAddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        elevation: 0.0,
        centerTitle: true,
        title: Text('新規申請', style: TextStyle(color: Colors.white)),
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
          SizedBox(height: 16.0),
          CustomSettingListTile(
            iconData: Icons.run_circle,
            title: '記録修正申請',
            onTap: () {},
          ),
          CustomSettingListTile(
            iconData: Icons.run_circle_outlined,
            title: '休暇申請',
            onTap: () {},
          ),
          CustomSettingListTile(
            iconData: Icons.run_circle_outlined,
            title: '残業申請',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
