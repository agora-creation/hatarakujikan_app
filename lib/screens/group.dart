import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/navigation.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/groups.dart';
import 'package:hatarakujikan_app/providers/group.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/screens/group_add.dart';
import 'package:hatarakujikan_app/screens/group_button.dart';
import 'package:hatarakujikan_app/screens/group_qr.dart';
import 'package:permission_handler/permission_handler.dart';

class GroupScreen extends StatefulWidget {
  final GroupProvider groupProvider;
  final UserProvider userProvider;

  GroupScreen({
    @required this.groupProvider,
    @required this.userProvider,
  });

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  GroupsModel selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: widget.userProvider.user.groups.length > 0
              ? ListView.builder(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  itemCount: widget.userProvider.user.groups.length,
                  itemBuilder: (_, index) {
                    GroupsModel _groups =
                        widget.userProvider.user.groups[index];
                    return Container(
                      decoration: kBottomBorderDecoration,
                      child: RadioListTile(
                        title: Text('アゴラクリエーション'),
                        subtitle: Text('既定'),
                        value: _groups,
                        groupValue: selected,
                        activeColor: Colors.blue,
                        controlAffinity: ListTileControlAffinity.trailing,
                        onChanged: (value) {},
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
              groupProvider: widget.groupProvider,
              userProvider: widget.userProvider,
            ),
          ),
          inOnPressed: () async {
            if (await Permission.camera.request().isGranted) {
              overlayScreen(context, GroupQRScreen());
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
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('キャンセル', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(backgroundColor: Colors.grey),
              ),
              TextButton(
                onPressed: () {
                  openAppSettings();
                },
                child: Text('はい', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
