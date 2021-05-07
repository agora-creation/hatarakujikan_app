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

  GroupDetailsScreen({
    @required this.groupProvider,
    @required this.userProvider,
    @required this.group,
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
                widget.group.fixed
                    ? RoundBackgroundButton(
                        labelText: '既定に設定中',
                        labelColor: Colors.white,
                        backgroundColor: Colors.grey,
                        labelFontSize: 16.0,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        onPressed: null,
                      )
                    : RoundBorderButton(
                        labelText: '既定に設定する',
                        labelColor: Colors.blue,
                        borderColor: Colors.blue,
                        labelFontSize: 16.0,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        onPressed: () async {
                          setState(() => _isLoading = true);
                          if (!await widget.groupProvider.updateFixed(
                              user: widget.userProvider.user,
                              groupId: widget.group.id)) {
                            setState(() => _isLoading = false);
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => ErrorMessage(
                                message: '設定に失敗しました。',
                              ),
                            );
                            return;
                          }
                          widget.userProvider.reloadUserModel();
                          setState(() => _isLoading = false);
                          Navigator.pop(context);
                        },
                      ),
                SizedBox(height: 8.0),
                RoundBorderButton(
                  labelText: '退職する',
                  labelColor: Colors.red,
                  borderColor: Colors.red,
                  labelFontSize: 16.0,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  onPressed: () {},
                ),
              ],
            ),
    );
  }
}
