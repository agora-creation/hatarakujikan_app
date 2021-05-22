import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/providers/group.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/screens/group_add.dart';
import 'package:hatarakujikan_app/screens/group_button.dart';
import 'package:hatarakujikan_app/screens/group_details.dart';
import 'package:hatarakujikan_app/screens/group_qr.dart';
import 'package:hatarakujikan_app/widgets/custom_group_list_tile.dart';
import 'package:hatarakujikan_app/widgets/custom_text_button.dart';
import 'package:permission_handler/permission_handler.dart';

class GroupScreen extends StatelessWidget {
  final GroupProvider groupProvider;
  final UserProvider userProvider;
  final String prefsGroupId;

  GroupScreen({
    @required this.groupProvider,
    @required this.userProvider,
    @required this.prefsGroupId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: userProvider.groups.length > 0
              ? ListView.builder(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  itemCount: userProvider.groups.length,
                  itemBuilder: (_, index) {
                    GroupModel _group = userProvider.groups[index];
                    return CustomGroupListTile(
                      group: _group,
                      fixed: _group.id == prefsGroupId,
                      onTap: () => nextScreen(
                        context,
                        GroupDetailsScreen(
                          groupProvider: groupProvider,
                          userProvider: userProvider,
                          group: _group,
                          prefsGroupId: prefsGroupId,
                        ),
                      ),
                    );
                  },
                )
              : Center(child: Text('会社/組織に所属しておりません')),
        ),
        GroupButton(
          createOnPressed: () => overlayScreen(
            context,
            GroupAddScreen(
              groupProvider: groupProvider,
              userProvider: userProvider,
            ),
          ),
          inOnPressed: () async {
            if (await Permission.camera.request().isGranted) {
              overlayScreen(
                context,
                GroupQRScreen(
                  groupProvider: groupProvider,
                  userProvider: userProvider,
                ),
              );
            } else {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => PermissionDialog(),
              );
            }
          },
        ),
      ],
    );
  }
}

class PermissionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'カメラを許可してください',
        style: TextStyle(fontSize: 18.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('QRコードを読み取る為にカメラを利用します'),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextButton(
                onPressed: () => Navigator.pop(context),
                labelText: 'キャンセル',
                backgroundColor: Colors.grey,
              ),
              CustomTextButton(
                onPressed: () => openAppSettings(),
                labelText: 'はい',
                backgroundColor: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
