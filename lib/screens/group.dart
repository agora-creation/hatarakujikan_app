import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/navigation.dart';
import 'package:hatarakujikan_app/screens/group_add.dart';
import 'package:hatarakujikan_app/screens/group_button.dart';
import 'package:permission_handler/permission_handler.dart';

class GroupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text('会社/組織に所属しておりません'),
          ),
        ),
        GroupButton(
          createOnPressed: () => overlayScreen(context, GroupAddScreen()),
          inOnPressed: () async {
            if (await Permission.camera.request().isGranted) {
              //
            } else {
              //
            }
          },
        ),
      ],
    );
  }
}
