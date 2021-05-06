import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/providers/group.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_app/widgets/error_message.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';

class GroupAddScreen extends StatefulWidget {
  final GroupProvider groupProvider;
  final UserProvider userProvider;

  GroupAddScreen({
    @required this.groupProvider,
    @required this.userProvider,
  });

  @override
  _GroupAddScreenState createState() => _GroupAddScreenState();
}

class _GroupAddScreenState extends State<GroupAddScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        elevation: 0.0,
        centerTitle: true,
        title: Text('会社/組織を作る', style: TextStyle(color: Colors.white)),
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
                CustomTextFormField(
                  controller: widget.groupProvider.name,
                  obscureText: false,
                  textInputType: TextInputType.name,
                  maxLines: 1,
                  labelText: '会社/組織名',
                  prefixIconData: Icons.store,
                  suffixIconData: null,
                  onTap: null,
                ),
                SizedBox(height: 16.0),
                Text(
                  '※会社/組織作成の際、あなたのアカウントが管理者に設定されます。',
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(height: 8.0),
                Container(
                  decoration: kTopBottomBorderDecoration,
                  child: ListTile(
                    title: Text('管理者'),
                    trailing: Text(widget.userProvider.user?.name ?? ''),
                  ),
                ),
                SizedBox(height: 8.0),
                Text('管理者は以下の利用権限があたえられます。あなたのメールアドレスとパスワードでご利用できます。'),
                Text('・タブレット端末での利用開始'),
                Text('・WEB管理画面の利用開始'),
                SizedBox(height: 24.0),
                RoundBackgroundButton(
                  labelText: '作成する',
                  labelColor: Colors.white,
                  backgroundColor: Colors.blue,
                  labelFontSize: 16.0,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  onPressed: () async {
                    setState(() => _isLoading = true);
                    if (!await widget.groupProvider
                        .create(user: widget.userProvider.user)) {
                      setState(() => _isLoading = false);
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => ErrorMessage(
                          message: '作成に失敗しました。',
                        ),
                      );
                      return;
                    }
                    widget.groupProvider.clearController();
                    widget.userProvider.reloadUserModel();
                    setState(() => _isLoading = false);
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ],
            ),
    );
  }
}
