import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/providers/group.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/widgets/error_message.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';
import 'package:hatarakujikan_app/widgets/round_border_button.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class GroupQRViewScreen extends StatefulWidget {
  final GroupProvider groupProvider;
  final UserProvider userProvider;
  final GroupModel group;
  final QRViewController qrController;

  GroupQRViewScreen(
      {@required this.groupProvider,
      @required this.userProvider,
      @required this.group,
      @required this.qrController});

  @override
  _GroupQRViewScreenState createState() => _GroupQRViewScreenState();
}

class _GroupQRViewScreenState extends State<GroupQRViewScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var contain = widget.userProvider.user.groups
        .where((e) => e.groupId == widget.group.id);

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
          ? Loading(size: 32.0, color: Colors.cyan)
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
                        labelText: 'この会社/組織に所属する',
                        labelColor: Colors.white,
                        backgroundColor: Colors.blue,
                        labelFontSize: 16.0,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        onPressed: () async {
                          setState(() => _isLoading = true);
                          if (!await widget.groupProvider.updateGroupIn(
                              user: widget.userProvider.user,
                              groupId: widget.group?.id)) {
                            setState(() => _isLoading = false);
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => ErrorMessage(
                                message: '所属に失敗しました。',
                              ),
                            );
                            return;
                          }
                          widget.userProvider.reloadUserModel();
                          widget.qrController?.resumeCamera();
                          setState(() => _isLoading = false);
                          Navigator.pop(context);
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                      )
                    : RoundBackgroundButton(
                        labelText: '既に所属済み',
                        labelColor: Colors.white,
                        backgroundColor: Colors.grey,
                        labelFontSize: 16.0,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        onPressed: null,
                      ),
                SizedBox(height: 8.0),
                RoundBorderButton(
                  labelText: 'もう一度読み取る',
                  labelColor: Colors.blue,
                  borderColor: Colors.blue,
                  labelFontSize: 16.0,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
    );
  }
}
