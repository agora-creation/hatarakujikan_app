import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';
import 'package:hatarakujikan_app/widgets/spin_kit.dart';
import 'package:provider/provider.dart';

class UserEmailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('ユーザー情報変更'),
      ),
      body: userProvider.isLoading
          ? SpinKitWidget(size: 32.0)
          : ListView(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              children: [
                CustomTextFormField(
                  controller: userProvider.name,
                  obscureText: false,
                  textInputType: TextInputType.name,
                  maxLines: 1,
                  labelText: 'お名前',
                  prefixIconData: Icons.person,
                  suffixIconData: null,
                  onTap: null,
                ),
                SizedBox(height: 16.0),
                CustomTextFormField(
                  controller: userProvider.email,
                  obscureText: false,
                  textInputType: TextInputType.emailAddress,
                  maxLines: 1,
                  labelText: 'メールアドレス',
                  prefixIconData: Icons.email,
                  suffixIconData: null,
                  onTap: null,
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
                    if (!await userProvider.updateEmail()) {
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
