import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_app/widgets/error_dialog.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';

class UserPasswordScreen extends StatelessWidget {
  final UserProvider userProvider;

  UserPasswordScreen({required this.userProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('パスワード再設定'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: 32.0),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          CustomTextFormField(
            controller: userProvider.password,
            obscureText: false,
            textInputType: null,
            maxLines: 1,
            label: '現在のパスワード',
            color: Colors.black54,
            prefix: Icons.lock,
          ),
          SizedBox(height: 8.0),
          CustomTextFormField(
            controller: userProvider.newPassword,
            obscureText: false,
            textInputType: null,
            maxLines: 1,
            label: '新しいパスワード',
            color: Colors.black54,
            prefix: Icons.lock_outlined,
          ),
          SizedBox(height: 8.0),
          CustomTextFormField(
            controller: userProvider.newRePassword,
            obscureText: false,
            textInputType: null,
            maxLines: 1,
            label: '新しいパスワードの再入力',
            color: Colors.black54,
            prefix: Icons.lock_outline,
          ),
          SizedBox(height: 16.0),
          RoundBackgroundButton(
            label: '変更を保存',
            color: Colors.white,
            backgroundColor: Colors.blue,
            onPressed: () async {
              if (!await userProvider.updatePassword()) {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => ErrorDialog('変更に失敗しました。'),
                );
                return;
              }
              userProvider.clearController();
              userProvider.reloadUser();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
