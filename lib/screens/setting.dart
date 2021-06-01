import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/providers/group.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/user_notice.dart';
import 'package:hatarakujikan_app/screens/company.dart';
import 'package:hatarakujikan_app/screens/group_create.dart';
import 'package:hatarakujikan_app/screens/login.dart';
import 'package:hatarakujikan_app/screens/push_permissions.dart';
import 'package:hatarakujikan_app/screens/user_email.dart';
import 'package:hatarakujikan_app/screens/user_password.dart';
import 'package:hatarakujikan_app/screens/user_work_password.dart';
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
    final groupProvider = Provider.of<GroupProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final userNoticeProvider = Provider.of<UserNoticeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('各種設定'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: _isLoading
          ? Loading(color: Colors.cyan)
          : ListView(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              children: [
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
                      context,
                      UserEmailScreen(userProvider: userProvider),
                    );
                  },
                ),
                CustomSettingListTile(
                  iconData: Icons.lock,
                  title: 'パスワード再設定',
                  onTap: () {
                    userProvider.clearController();
                    nextScreen(
                      context,
                      UserPasswordScreen(userProvider: userProvider),
                    );
                  },
                ),
                CustomSettingListTile(
                  iconData: Icons.vpn_key,
                  title: 'タブレット用の暗証番号',
                  onTap: () {
                    userProvider.clearController();
                    userProvider.workPassword.text =
                        userProvider.user.workPassword;
                    nextScreen(
                      context,
                      UserWorkPasswordScreen(userProvider: userProvider),
                    );
                  },
                ),
                CustomSettingListTile(
                  iconData: Icons.notifications,
                  title: 'PUSH通知の許可',
                  onTap: () {
                    userNoticeProvider.requestPermissions();
                    nextScreen(
                      context,
                      PushPermissionsScreen(
                        userNoticeProvider: userNoticeProvider,
                      ),
                    );
                  },
                ),
                SizedBox(height: 16.0),
                Text('会社/組織情報'),
                SizedBox(height: 8.0),
                Divider(height: 1.0, color: Colors.grey),
                CustomSettingListTile(
                  iconData: Icons.store,
                  title: '会社/組織の作成申請',
                  onTap: () {
                    groupProvider.clearController();
                    nextScreen(
                      context,
                      GroupCreateScreen(
                        groupProvider: groupProvider,
                        userProvider: userProvider,
                      ),
                    );
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
                SizedBox(height: 16.0),
                RoundBorderButton(
                  onPressed: () {
                    setState(() => _isLoading = true);
                    userProvider.signOut();
                    setState(() => _isLoading = false);
                    changeScreen(context, LoginScreen());
                  },
                  labelText: 'ログアウト',
                  labelColor: Colors.blue,
                  borderColor: Colors.blue,
                ),
                SizedBox(height: 40.0),
              ],
            ),
    );
  }
}
