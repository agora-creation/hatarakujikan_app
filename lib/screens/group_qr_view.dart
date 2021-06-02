import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/providers/group.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/widgets/error_message.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';
import 'package:hatarakujikan_app/widgets/round_border_button.dart';

class GroupQRViewScreen extends StatefulWidget {
  final GroupProvider groupProvider;
  final UserProvider userProvider;
  final GroupModel group;

  GroupQRViewScreen({
    @required this.groupProvider,
    @required this.userProvider,
    @required this.group,
  });

  @override
  _GroupQRViewScreenState createState() => _GroupQRViewScreenState();
}

class _GroupQRViewScreenState extends State<GroupQRViewScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var contain =
        widget.userProvider.user.groups.where((e) => e == widget.group.id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('QRコード読み取り結果', style: TextStyle(color: Colors.blue)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left, size: 32.0, color: Colors.blue),
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
                    trailing: Text(widget.group?.id),
                  ),
                ),
                Container(
                  decoration: kBottomBorderDecoration,
                  child: ListTile(
                    title: Text(
                      '会社/組織名',
                      style: TextStyle(color: Colors.black54),
                    ),
                    trailing: Text(widget.group?.name),
                  ),
                ),
                SizedBox(height: 16.0),
                contain.isEmpty
                    ? RoundBackgroundButton(
                        onPressed: () async {
                          setState(() => _isLoading = true);
                          if (!await widget.groupProvider.updateIn(
                              user: widget.userProvider.user,
                              groupId: widget.group?.id)) {
                            setState(() => _isLoading = false);
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => ErrorMessage('所属に失敗しました。'),
                            );
                            return;
                          }
                          widget.userProvider.reloadUserModel();
                          setState(() => _isLoading = false);
                          Navigator.pop(context);
                        },
                        labelText: 'この会社/組織に所属する',
                        labelColor: Colors.white,
                        backgroundColor: Colors.blue,
                      )
                    : RoundBackgroundButton(
                        onPressed: null,
                        labelText: '既に所属済み',
                        labelColor: Colors.white,
                        backgroundColor: Colors.grey,
                      ),
                SizedBox(height: 8.0),
                RoundBorderButton(
                  onPressed: () => Navigator.pop(context),
                  labelText: 'もう一度読み取る',
                  labelColor: Colors.blue,
                  borderColor: Colors.blue,
                ),
                SizedBox(height: 40.0),
              ],
            ),
    );
  }
}