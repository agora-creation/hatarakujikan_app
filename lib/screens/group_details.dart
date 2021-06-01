import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/providers/group.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/widgets/error_message.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';
import 'package:hatarakujikan_app/widgets/round_border_button.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GroupDetailsScreen extends StatefulWidget {
  final GroupProvider groupProvider;
  final UserProvider userProvider;
  final GroupModel group;
  final String groupId;

  GroupDetailsScreen({
    @required this.groupProvider,
    @required this.userProvider,
    @required this.group,
    @required this.groupId,
  });

  @override
  _GroupDetailsScreenState createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text(widget.group.name),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left, size: 32.0, color: Colors.black54),
        ),
      ),
      body: _isLoading
          ? Loading(color: Colors.cyan)
          : ListView(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              children: [
                Container(
                  decoration: kBottomBorderDecoration,
                  child: ListTile(
                    title: Text(
                      'ID',
                      style: TextStyle(color: Colors.black54),
                    ),
                    trailing: Text(widget.group.id),
                  ),
                ),
                Container(
                  decoration: kBottomBorderDecoration,
                  child: ListTile(
                    title: Text(
                      '会社/組織名',
                      style: TextStyle(color: Colors.black54),
                    ),
                    trailing: Text(widget.group.name),
                  ),
                ),
                SizedBox(height: 16.0),
                Center(
                  child: QrImage(
                    data: '${widget.group.id}',
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
                SizedBox(height: 16.0),
                widget.groupId == widget.group.id
                    ? RoundBackgroundButton(
                        onPressed: null,
                        labelText: '既定に設定中',
                        labelColor: Colors.white,
                        backgroundColor: Colors.grey,
                      )
                    : RoundBorderButton(
                        onPressed: () async {
                          setState(() => _isLoading = true);
                          if (!await widget.groupProvider
                              .updatePrefs(groupId: widget.group.id)) {
                            setState(() => _isLoading = false);
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => ErrorMessage('設定に失敗しました。'),
                            );
                            return;
                          }
                          widget.userProvider.reloadUserModel();
                          setState(() => _isLoading = false);
                          Navigator.pop(context);
                        },
                        labelText: '既定に設定する',
                        labelColor: Colors.blue,
                        borderColor: Colors.blue,
                      ),
                SizedBox(height: 8.0),
                widget.userProvider.user?.id != widget.group.adminUserId
                    ? RoundBorderButton(
                        onPressed: () async {
                          setState(() => _isLoading = true);
                          if (!await widget.groupProvider.updateExit(
                              user: widget.userProvider.user,
                              groupId: widget.group.id)) {
                            setState(() => _isLoading = false);
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => ErrorMessage('退職に失敗しました。'),
                            );
                            return;
                          }
                          widget.userProvider.reloadUserModel();
                          setState(() => _isLoading = false);
                          Navigator.pop(context);
                        },
                        labelText: '退職する',
                        labelColor: Colors.red,
                        borderColor: Colors.red,
                      )
                    : RoundBackgroundButton(
                        onPressed: null,
                        labelText: '退職する',
                        labelColor: Colors.white,
                        backgroundColor: Colors.grey,
                      ),
                Center(
                  child: Text(
                    '※管理者は退職できません',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                SizedBox(height: 40.0),
              ],
            ),
    );
  }
}
