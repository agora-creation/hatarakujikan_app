import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_app/widgets/error_dialog.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';

class UserPasswordScreen extends StatefulWidget {
  final UserProvider userProvider;

  UserPasswordScreen({@required this.userProvider});

  @override
  _UserPasswordScreenState createState() => _UserPasswordScreenState();
}

class _UserPasswordScreenState extends State<UserPasswordScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('パスワード再設定'),
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
                  controller: widget.userProvider.password,
                  obscureText: widget.userProvider.isHidden ? false : true,
                  textInputType: null,
                  maxLines: 1,
                  label: '新しいパスワード',
                  color: Colors.black54,
                  prefix: Icons.lock,
                  suffix: widget.userProvider.isHidden
                      ? Icons.visibility
                      : Icons.visibility_off,
                  onTap: () => widget.userProvider.changeHidden(),
                ),
                SizedBox(height: 8.0),
                CustomTextFormField(
                  controller: widget.userProvider.rePassword,
                  obscureText: widget.userProvider.isReHidden ? false : true,
                  textInputType: null,
                  maxLines: 1,
                  label: '新しいパスワードの再入力',
                  color: Colors.black54,
                  prefix: Icons.lock_outline,
                  suffix: widget.userProvider.isReHidden
                      ? Icons.visibility
                      : Icons.visibility_off,
                  onTap: () => widget.userProvider.changeReHidden(),
                ),
                SizedBox(height: 16.0),
                RoundBackgroundButton(
                  onPressed: () async {
                    setState(() => _isLoading = true);
                    if (!await widget.userProvider.updatePassword()) {
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
