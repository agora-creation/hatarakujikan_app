import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/providers/group.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/widgets/error_message.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';
import 'package:hatarakujikan_app/widgets/round_border_button.dart';

class GroupQRViewScreen extends StatefulWidget {
  final GroupProvider groupProvider;
  final UserProvider userProvider;
  final String type;
  final String data;

  GroupQRViewScreen({
    @required this.groupProvider,
    @required this.userProvider,
    @required this.type,
    @required this.data,
  });

  @override
  _GroupQRViewScreenState createState() => _GroupQRViewScreenState();
}

class _GroupQRViewScreenState extends State<GroupQRViewScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
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
          ? Loading(size: 32.0)
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
                    trailing: Text('${widget.data}'),
                  ),
                ),
                Container(
                  decoration: kBottomBorderDecoration,
                  child: ListTile(
                    title: Text(
                      '会社/組織名',
                      style: TextStyle(color: Colors.black54),
                    ),
                    trailing: Text(''),
                  ),
                ),
                SizedBox(height: 16.0),
                RoundBackgroundButton(
                  labelText: 'この会社/組織に所属する',
                  labelColor: Colors.white,
                  backgroundColor: Colors.blue,
                  labelFontSize: 16.0,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  onPressed: () async {
                    setState(() => _isLoading = true);
                    if (!await widget.groupProvider.updateGroupIn(
                        user: widget.userProvider.user, groupId: widget.data)) {
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
                    setState(() => _isLoading = false);
                    Navigator.pop(context);
                    Navigator.of(context, rootNavigator: true).pop();
                  },
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
