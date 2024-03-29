import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_app/widgets/error_dialog.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';

class UserEmailScreen extends StatefulWidget {
  final UserProvider userProvider;

  UserEmailScreen({required this.userProvider});

  @override
  _UserEmailScreenState createState() => _UserEmailScreenState();
}

class _UserEmailScreenState extends State<UserEmailScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('ユーザー情報変更'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: 32.0),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? Loading(color: Colors.cyan)
          : ListView(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              children: [
                CustomTextFormField(
                  controller: widget.userProvider.name,
                  obscureText: false,
                  textInputType: TextInputType.name,
                  maxLines: 1,
                  label: 'お名前',
                  color: Colors.black54,
                  prefix: Icons.person,
                ),
                SizedBox(height: 8.0),
                CustomTextFormField(
                  controller: widget.userProvider.email,
                  obscureText: false,
                  textInputType: TextInputType.emailAddress,
                  maxLines: 1,
                  label: 'メールアドレス',
                  color: Colors.black54,
                  prefix: Icons.email,
                ),
                SizedBox(height: 16.0),
                RoundBackgroundButton(
                  label: '変更を保存',
                  color: Colors.white,
                  backgroundColor: Colors.blue,
                  onPressed: () async {
                    setState(() => _isLoading = true);
                    if (!await widget.userProvider.updateEmail()) {
                      setState(() => _isLoading = false);
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => ErrorDialog('変更に失敗しました。'),
                      );
                      return;
                    }
                    widget.userProvider.clearController();
                    widget.userProvider.reloadUser();
                    setState(() => _isLoading = false);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
    );
  }
}
