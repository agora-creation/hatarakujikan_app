import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/providers/group.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/widgets/error_dialog.dart';
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
    var contain = widget.userProvider.groups.where(
      (e) => e.id == widget.group?.id,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('QRコード読取結果', style: TextStyle(color: Colors.blue)),
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
                      '会社/組織名',
                      style: TextStyle(color: Colors.black54),
                    ),
                    trailing: Text(widget.group?.name ?? ''),
                  ),
                ),
                SizedBox(height: 16.0),
                contain.isEmpty
                    ? RoundBackgroundButton(
                        onPressed: () async {
                          setState(() => _isLoading = true);
                          if (!await widget.groupProvider.updateIn(
                            group: widget.group,
                            user: widget.userProvider.user,
                          )) {
                            setState(() => _isLoading = false);
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => ErrorDialog('所属に失敗しました。'),
                            );
                            return;
                          }
                          widget.userProvider.reloadUserModel();
                          setState(() => _isLoading = false);
                          Navigator.pop(context);
                        },
                        label: 'この会社/組織に所属する',
                        color: Colors.white,
                        backgroundColor: Colors.blue,
                      )
                    : RoundBackgroundButton(
                        onPressed: null,
                        label: '既に所属済み',
                        color: Colors.white,
                        backgroundColor: Colors.grey,
                      ),
                SizedBox(height: 8.0),
                RoundBorderButton(
                  onPressed: () => Navigator.pop(context),
                  label: 'もう一度読み取る',
                  color: Colors.blue,
                  borderColor: Colors.blue,
                ),
                SizedBox(height: 40.0),
              ],
            ),
    );
  }
}
