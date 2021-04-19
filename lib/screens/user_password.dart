import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';
import 'package:provider/provider.dart';

class UserPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5F5),
        elevation: 0.0,
        centerTitle: true,
        title: Text('パスワード再設定'),
      ),
      body: userProvider.isLoading
          ? Loading(size: 32.0)
          : ListView(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              children: [
                SizedBox(height: 16.0),
                CustomTextFormField(
                  controller: userProvider.password,
                  obscureText: userProvider.isHidden ? false : true,
                  textInputType: null,
                  maxLines: 1,
                  labelText: '新しいパスワード',
                  prefixIconData: Icons.lock,
                  suffixIconData: userProvider.isHidden
                      ? Icons.visibility
                      : Icons.visibility_off,
                  onTap: () => userProvider.changeHidden(),
                ),
                SizedBox(height: 16.0),
                CustomTextFormField(
                  controller: userProvider.rePassword,
                  obscureText: userProvider.isReHidden ? false : true,
                  textInputType: null,
                  maxLines: 1,
                  labelText: '新しいパスワードの再入力',
                  prefixIconData: Icons.lock_outline,
                  suffixIconData: userProvider.isReHidden
                      ? Icons.visibility
                      : Icons.visibility_off,
                  onTap: () => userProvider.changeReHidden(),
                ),
                SizedBox(height: 24.0),
                RoundBackgroundButton(
                  labelText: '変更を保存',
                  labelColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  labelFontSize: 16.0,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  onPressed: () async {
                    userProvider.changeLoading();
                    if (!await userProvider.updatePassword()) {
                      userProvider.changeLoading();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('変更に失敗しました')),
                      );
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('変更に成功しました')),
                    );
                    userProvider.clearController();
                    userProvider.reloadUserModel();
                    userProvider.changeLoading();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
    );
  }
}
