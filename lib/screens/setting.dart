import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/user_notice.dart';
import 'package:hatarakujikan_app/screens/login.dart';
import 'package:hatarakujikan_app/screens/push_permissions.dart';
import 'package:hatarakujikan_app/screens/user_email.dart';
import 'package:hatarakujikan_app/screens/user_password.dart';
import 'package:hatarakujikan_app/screens/user_record_password.dart';
import 'package:hatarakujikan_app/widgets/custom_link_button.dart';
import 'package:hatarakujikan_app/widgets/custom_setting_list_tile.dart';
import 'package:hatarakujikan_app/widgets/custom_text_button.dart';
import 'package:hatarakujikan_app/widgets/round_border_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatelessWidget {
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
      body: ListView(
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
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => SignOutDialog(
                  userProvider: userProvider,
                ),
              );
            },
            label: 'ログアウト',
            color: Colors.blue,
            borderColor: Colors.blue,
          ),
          SizedBox(height: 32.0),
          Center(
            child: CustomLinkButton(
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => DeleteDialog(
                    userProvider: userProvider,
                  ),
                );
              },
              label: 'このアカウントを削除する',
              color: Colors.red,
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

  SignOutDialog({@required this.userProvider});

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
                onPressed: () => Navigator.pop(context),
                label: 'キャンセル',
                color: Colors.grey,
              ),
              CustomTextButton(
                onPressed: () async {
                  await userProvider.signOut();
                  Navigator.pop(context);
                  changeScreen(context, LoginScreen());
                },
                label: 'はい',
                color: Colors.blue,
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

  DeleteDialog({@required this.userProvider});

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
                onPressed: () => Navigator.pop(context),
                label: 'キャンセル',
                color: Colors.grey,
              ),
              CustomTextButton(
                onPressed: () async {
                  await userProvider.delete();
                  Navigator.pop(context);
                  changeScreen(context, LoginScreen());
                },
                label: 'はい',
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
