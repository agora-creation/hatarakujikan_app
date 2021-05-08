import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_app/widgets/error_message.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';

class UserEmailScreen extends StatefulWidget {
  final UserProvider userProvider;

  UserEmailScreen({@required this.userProvider});

  @override
  _UserEmailScreenState createState() => _UserEmailScreenState();
}

class _UserEmailScreenState extends State<UserEmailScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('ユーザー情報変更'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left, size: 32.0),
        ),
      ),
      body: _isLoading
          ? Loading(size: 32.0)
          : ListView(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              children: [
                SizedBox(height: 16.0),
                CustomTextFormField(
                  controller: widget.userProvider.name,
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
                  controller: widget.userProvider.email,
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
                  backgroundColor: Colors.blue,
                  labelFontSize: 16.0,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  onPressed: () async {
                    setState(() => _isLoading = true);
                    if (!await widget.userProvider.updateEmail()) {
                      setState(() => _isLoading = false);
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => ErrorMessage(
                          message: '変更に失敗しました。',
                        ),
                      );
                      return;
                    }
                    widget.userProvider.clearController();
                    widget.userProvider.reloadUserModel();
                    setState(() => _isLoading = false);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
    );
  }
}
