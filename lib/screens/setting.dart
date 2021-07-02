import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/user_notice.dart';
import 'package:hatarakujikan_app/screens/login.dart';
import 'package:hatarakujikan_app/screens/push_permissions.dart';
import 'package:hatarakujikan_app/screens/user_email.dart';
import 'package:hatarakujikan_app/screens/user_password.dart';
import 'package:hatarakujikan_app/screens/user_record_password.dart';
import 'package:hatarakujikan_app/widgets/custom_setting_list_tile.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';
import 'package:hatarakujikan_app/widgets/round_border_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
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
                  onTap: () {
                    userProvider.clearController();
                    userProvider.name.text = userProvider.user?.name;
                    userProvider.email.text = userProvider.user?.email;
                    nextScreen(
                      context,
                      UserEmailScreen(userProvider: userProvider),
                    );
                  },
                  iconData: Icons.person,
                  label: 'ユーザー情報変更',
                ),
                CustomSettingListTile(
                  onTap: () {
                    userProvider.clearController();
                    nextScreen(
                      context,
                      UserPasswordScreen(userProvider: userProvider),
                    );
                  },
                  iconData: Icons.lock,
                  label: 'パスワード再設定',
                ),
                CustomSettingListTile(
                  onTap: () {
                    userProvider.clearController();
                    userProvider.recordPassword.text =
                        userProvider.user?.recordPassword;
                    nextScreen(
                      context,
                      UserRecordPasswordScreen(userProvider: userProvider),
                    );
                  },
                  iconData: Icons.vpn_key,
                  label: 'タブレット用暗証番号',
                ),
                CustomSettingListTile(
                  onTap: () {
                    userNoticeProvider.requestPermissions();
                    nextScreen(
                      context,
                      PushPermissionsScreen(
                        userNoticeProvider: userNoticeProvider,
                      ),
                    );
                  },
                  iconData: Icons.notifications,
                  label: 'PUSH通知の許可',
                ),
                SizedBox(height: 16.0),
                Text('会社/組織情報'),
                SizedBox(height: 8.0),
                Divider(height: 1.0, color: Colors.grey),
                CustomSettingListTile(
                  onTap: () async {
                    const url = 'https://www.agora-c.com/hatarakujikan/';
                    if (await canLaunch(url)) {
                      await launch(
                        url,
                        forceSafariVC: false,
                        forceWebView: false,
                      );
                    } else {
                      throw 'このURLにはアクセスできません';
                    }
                  },
                  iconData: Icons.store,
                  label: '会社/組織の作成申請',
                ),
                SizedBox(height: 16.0),
                Text('アプリ情報'),
                SizedBox(height: 8.0),
                Divider(height: 1.0, color: Colors.grey),
                CustomSettingListTile(
                  onTap: () async {
                    const url = 'https://www.agora-c.com/';
                    if (await canLaunch(url)) {
                      await launch(
                        url,
                        forceSafariVC: false,
                        forceWebView: false,
                      );
                    } else {
                      throw 'このURLにはアクセスできません';
                    }
                  },
                  iconData: Icons.business_outlined,
                  label: '開発/運営会社',
                ),
                SizedBox(height: 16.0),
                RoundBorderButton(
                  onPressed: () {
                    setState(() => _isLoading = true);
                    userProvider.signOut();
                    setState(() => _isLoading = false);
                    changeScreen(context, LoginScreen());
                  },
                  label: 'ログアウト',
                  color: Colors.blue,
                  borderColor: Colors.blue,
                ),
                SizedBox(height: 40.0),
              ],
            ),
    );
  }
}
