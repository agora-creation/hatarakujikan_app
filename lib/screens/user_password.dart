import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_app/widgets/error_message.dart';
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
          ? Loading(size: 32.0, color: Colors.cyan)
          : ListView(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              children: [
                SizedBox(height: 16.0),
                CustomTextFormField(
                  controller: widget.userProvider.password,
                  obscureText: widget.userProvider.isHidden ? false : true,
                  textInputType: null,
                  maxLines: 1,
                  labelText: '新しいパスワード',
                  labelColor: Colors.black54,
                  prefixIconData: Icons.lock,
                  suffixIconData: widget.userProvider.isHidden
                      ? Icons.visibility
                      : Icons.visibility_off,
                  onTap: () => widget.userProvider.changeHidden(),
                ),
                SizedBox(height: 16.0),
                CustomTextFormField(
                  controller: widget.userProvider.rePassword,
                  obscureText: widget.userProvider.isReHidden ? false : true,
                  textInputType: null,
                  maxLines: 1,
                  labelText: '新しいパスワードの再入力',
                  labelColor: Colors.black54,
                  prefixIconData: Icons.lock_outline,
                  suffixIconData: widget.userProvider.isReHidden
                      ? Icons.visibility
                      : Icons.visibility_off,
                  onTap: () => widget.userProvider.changeReHidden(),
                ),
                SizedBox(height: 24.0),
                RoundBackgroundButton(
                  labelText: '変更を保存',
                  labelColor: Colors.white,
                  backgroundColor: Colors.blue,
                  onPressed: () async {
                    setState(() => _isLoading = true);
                    if (!await widget.userProvider.updatePassword()) {
                      setState(() => _isLoading = false);
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => ErrorMessage(
                          message: '変更に失敗しました。',
                        ),
                      );
                      return;
                    }
                    widget.userProvider.clearController();
                    widget.userProvider.reloadUserModel();
                    setState(() => _isLoading = false);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
    );
  }
}
