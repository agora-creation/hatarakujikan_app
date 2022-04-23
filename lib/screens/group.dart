import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/dialogs.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/providers/group.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/screens/group_details.dart';
import 'package:hatarakujikan_app/screens/group_qr.dart';
import 'package:hatarakujikan_app/widgets/custom_group_list_tile.dart';
import 'package:hatarakujikan_app/widgets/expanded_button.dart';
import 'package:permission_handler/permission_handler.dart';

class GroupScreen extends StatefulWidget {
  final GroupProvider groupProvider;
  final UserProvider userProvider;

  GroupScreen({
    required this.groupProvider,
    required this.userProvider,
  });

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  String _prefsGroupId = '';

  void _init() async {
    String? _prefs = await getPrefs('groupId');
    setState(() => _prefsGroupId = _prefs ?? '');
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    List<GroupModel> _groups = widget.userProvider.groups;

    return Column(
      children: [
        Expanded(
          child: _groups.length > 0
              ? ListView.builder(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  itemCount: _groups.length,
                  itemBuilder: (_, index) {
                    GroupModel _group = _groups[index];
                    return CustomGroupListTile(
                      onTap: () => nextScreen(
                        context,
                        GroupDetailsScreen(
                          groupProvider: widget.groupProvider,
                          userProvider: widget.userProvider,
                          group: _group,
                        ),
                      ),
                      group: _group,
                      fixed: _group.id == _prefsGroupId,
                    );
                  },
                )
              : Center(child: Text('会社/組織に所属しておりません')),
        ),
        ExpandedButton(
          onTap: () async {
            if (await Permission.camera.request().isGranted) {
              overlayScreen(
                context,
                GroupQRScreen(
                  groupProvider: widget.groupProvider,
                  userProvider: widget.userProvider,
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
          backgroundColor: Colors.blue,
          label: '会社/組織に入る',
          color: Colors.white,
          leading: Icon(Icons.qr_code_scanner, color: Colors.white),
          trailing: null,
        ),
      ],
    );
  }
}
