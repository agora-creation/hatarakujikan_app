import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_app/widgets/error_dialog.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';

class UserRecordPasswordScreen extends StatefulWidget {
  final UserProvider userProvider;

  UserRecordPasswordScreen({required this.userProvider});

  @override
  _UserRecordPasswordScreenState createState() =>
      _UserRecordPasswordScreenState();
}

class _UserRecordPasswordScreenState extends State<UserRecordPasswordScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('タブレット用暗証番号'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left, size: 32.0),
        ),
      ),
      body: _isLoading
          ? Loading(color: Colors.cyan)
          : ListView(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              children: [
                CustomTextFormField(
                  controller: widget.userProvider.recordPassword,
                  obscureText: false,
                  textInputType: TextInputType.number,
                  maxLines: 1,
                  label: '暗証番号',
                  color: Colors.black54,
                  prefix: Icons.vpn_key,
                  suffix: null,
                  onTap: null,
                ),
                SizedBox(height: 8.0),
                Text('※タブレットアプリ内で、このユーザーにログインするときに必要な暗証番号です。数字8桁以内でご入力ください。'),
                SizedBox(height: 16.0),
                RoundBackgroundButton(
                  onPressed: () async {
                    setState(() => _isLoading = true);
                    if (!await widget.userProvider.updateRecordPassword()) {
                      setState(() => _isLoading = false);
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => ErrorDialog('変更に失敗しました。'),
                      );
                      return;
                    }
                    widget.userProvider.clearController();
                    widget.userProvider.reloadUserModel();
                    setState(() => _isLoading = false);
                    Navigator.pop(context);
                  },
                  label: '変更を保存',
                  color: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                SizedBox(height: 40.0),
              ],
            ),
    );
  }
}
