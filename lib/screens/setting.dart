import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/navigation.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/screens/company.dart';
import 'package:hatarakujikan_app/screens/login.dart';
import 'package:hatarakujikan_app/screens/user_email.dart';
import 'package:hatarakujikan_app/screens/user_password.dart';
import 'package:hatarakujikan_app/widgets/custom_setting_list_tile.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';
import 'package:hatarakujikan_app/widgets/round_border_button.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey,
        elevation: 0.0,
        centerTitle: true,
        title: Text('各種設定', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
      body: _isLoading
          ? Loading(size: 32.0)
          : ListView(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              children: [
                SizedBox(height: 16.0),
                Text('ユーザー情報'),
                SizedBox(height: 8.0),
                Divider(height: 1.0, color: Colors.grey),
                CustomSettingListTile(
                  iconData: Icons.person,
                  title: 'ユーザー情報変更',
                  onTap: () {
                    userProvider.clearController();
                    userProvider.name.text = userProvider.user.name;
                    userProvider.email.text = userProvider.user.email;
                    nextScreen(
                        context, UserEmailScreen(userProvider: userProvider));
                  },
                ),
                CustomSettingListTile(
                  iconData: Icons.lock,
                  title: 'パスワード再設定',
                  onTap: () {
                    userProvider.clearController();
                    nextScreen(context,
                        UserPasswordScreen(userProvider: userProvider));
                  },
                ),
                SizedBox(height: 16.0),
                Text('アプリ情報'),
                SizedBox(height: 8.0),
                Divider(height: 1.0, color: Colors.grey),
                CustomSettingListTile(
                  iconData: Icons.business_outlined,
                  title: '開発/運営会社',
                  onTap: () => nextScreen(context, CompanyScreen()),
                ),
                SizedBox(height: 24.0),
                RoundBorderButton(
                  labelText: 'ログアウト',
                  labelColor: Colors.blue,
                  borderColor: Colors.blue,
                  labelFontSize: 16.0,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  onPressed: () {
                    setState(() => _isLoading = true);
                    userProvider.signOut();
                    setState(() => _isLoading = false);
                    changeScreen(context, LoginScreen());
                  },
                ),
              ],
            ),
    );
  }
}
