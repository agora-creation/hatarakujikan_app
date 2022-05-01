import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/providers/group.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/widgets/custom_list_tile.dart';
import 'package:hatarakujikan_app/widgets/error_dialog.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';
import 'package:hatarakujikan_app/widgets/round_border_button.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GroupDetailsScreen extends StatefulWidget {
  final GroupProvider groupProvider;
  final UserProvider userProvider;
  final GroupModel group;

  GroupDetailsScreen({
    required this.groupProvider,
    required this.userProvider,
    required this.group,
  });

  @override
  _GroupDetailsScreenState createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  bool _isLoading = false;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text(widget.group.name),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: 32.0, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? Loading(color: Colors.cyan)
          : ListView(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              children: [
                CustomListTile(
                  label: '会社/組織名',
                  value: widget.group.name,
                ),
                SizedBox(height: 16.0),
                Center(
                  child: QrImage(
                    data: widget.group.id,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
                SizedBox(height: 16.0),
                _prefsGroupId == widget.group.id
                    ? RoundBackgroundButton(
                        label: '既定に設定中',
                        color: Colors.white,
                        backgroundColor: Colors.grey,
                      )
                    : RoundBorderButton(
                        label: '既定に設定する',
                        color: Colors.blue,
                        borderColor: Colors.blue,
                        onPressed: () async {
                          setState(() => _isLoading = true);
                          if (!await widget.groupProvider.updatePrefs(
                            groupId: widget.group.id,
                          )) {
                            setState(() => _isLoading = false);
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => ErrorDialog('設定に失敗しました。'),
                            );
                            return;
                          }
                          widget.userProvider.reloadUser();
                          setState(() => _isLoading = false);
                          Navigator.pop(context);
                        },
                      ),
                SizedBox(height: 8.0),
                widget.userProvider.user?.id != widget.group.adminUserId
                    ? RoundBorderButton(
                        label: '退職する',
                        color: Colors.red,
                        borderColor: Colors.red,
                        onPressed: () async {
                          setState(() => _isLoading = true);
                          if (!await widget.groupProvider.updateExit(
                            user: widget.userProvider.user,
                            group: widget.group,
                          )) {
                            setState(() => _isLoading = false);
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => ErrorDialog('退職に失敗しました。'),
                            );
                            return;
                          }
                          widget.userProvider.reloadUser();
                          setState(() => _isLoading = false);
                          Navigator.pop(context);
                        },
                      )
                    : RoundBackgroundButton(
                        label: '退職する',
                        color: Colors.white,
                        backgroundColor: Colors.grey,
                      ),
                Center(
                  child: Text(
                    '※管理者アカウントは退職できません。',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
    );
  }
}
