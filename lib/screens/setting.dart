import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/user_notice.dart';
import 'package:hatarakujikan_app/screens/login.dart';
import 'package:hatarakujikan_app/screens/push_permissions.dart';
import 'package:hatarakujikan_app/screens/user_email.dart';
import 'package:hatarakujikan_app/screens/user_password.dart';
import 'package:hatarakujikan_app/screens/user_record_password.dart';
import 'package:hatarakujikan_app/widgets/custom_link_button.dart';
import 'package:hatarakujikan_app/widgets/custom_text_button.dart';
import 'package:hatarakujikan_app/widgets/round_border_button.dart';
import 'package:hatarakujikan_app/widgets/setting_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatelessWidget {
  final UserProvider userProvider;
  final UserNoticeProvider userNoticeProvider;

  SettingScreen({
    required this.userProvider,
    required this.userNoticeProvider,
  });

  @override
  Widget build(BuildContext context) {
    UserModel? _user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('各種設定'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          Text('ユーザー情報'),
          SizedBox(height: 8.0),
          Divider(height: 1.0, color: Colors.grey),
          SettingListTile(
            iconData: Icons.person,
            label: 'ユーザー情報変更',
            onTap: () {
              userProvider.clearController();
              userProvider.name.text = _user?.name ?? '';
              userProvider.email.text = _user?.email ?? '';
              nextScreen(
                context,
                UserEmailScreen(userProvider: userProvider),
              );
            },
          ),
          SettingListTile(
            iconData: Icons.lock,
            label: 'パスワード再設定',
            onTap: () {
              userProvider.clearController();
              nextScreen(
                context,
                UserPasswordScreen(userProvider: userProvider),
              );
            },
          ),
          SettingListTile(
            iconData: Icons.vpn_key,
            label: 'タブレット用暗証番号',
            onTap: () {
              userProvider.clearController();
              userProvider.recordPassword.text = _user?.recordPassword ?? '';
              nextScreen(
                context,
                UserRecordPasswordScreen(userProvider: userProvider),
              );
            },
          ),
          SettingListTile(
            iconData: Icons.notifications,
            label: 'PUSH通知の許可',
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
          SettingListTile(
            iconData: Icons.store,
            label: '会社/組織の作成申請',
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
          ),
          SizedBox(height: 16.0),
          Text('アプリ情報'),
          SizedBox(height: 8.0),
          Divider(height: 1.0, color: Colors.grey),
          SettingListTile(
            iconData: Icons.business_outlined,
            label: '開発/運営会社',
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
          ),
          SizedBox(height: 16.0),
          RoundBorderButton(
            label: 'ログアウト',
            color: Colors.blue,
            borderColor: Colors.blue,
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => SignOutDialog(
                  userProvider: userProvider,
                ),
              );
            },
          ),
          SizedBox(height: 32.0),
          Center(
            child: CustomLinkButton(
              label: 'このアカウントを削除する',
              color: Colors.red,
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => DeleteDialog(
                    userProvider: userProvider,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }
}

class SignOutDialog extends StatelessWidget {
  final UserProvider userProvider;

  SignOutDialog({required this.userProvider});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ログアウトします。よろしいですか？'),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextButton(
                label: 'キャンセル',
                color: Colors.grey,
                onPressed: () => Navigator.pop(context),
              ),
              CustomTextButton(
                label: 'はい',
                color: Colors.blue,
                onPressed: () async {
                  await userProvider.signOut();
                  changeScreen(context, LoginScreen());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DeleteDialog extends StatelessWidget {
  final UserProvider userProvider;

  DeleteDialog({required this.userProvider});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('このアカウントを削除します。よろしいですか？'),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextButton(
                label: 'キャンセル',
                color: Colors.grey,
                onPressed: () => Navigator.pop(context),
              ),
              CustomTextButton(
                label: 'はい',
                color: Colors.blue,
                onPressed: () async {
                  await userProvider.delete();
                  changeScreen(context, LoginScreen());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
