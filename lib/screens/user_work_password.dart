import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_app/widgets/error_message.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';

class UserWorkPasswordScreen extends StatefulWidget {
  final UserProvider userProvider;

  UserWorkPasswordScreen({@required this.userProvider});

  @override
  _UserWorkPasswordScreenState createState() => _UserWorkPasswordScreenState();
}

class _UserWorkPasswordScreenState extends State<UserWorkPasswordScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('タブレット用の暗証番号'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left, size: 32.0),
        ),
      ),
      body: _isLoading
          ? Loading(color: Colors.cyan)
          : ListView(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              children: [
                CustomTextFormField(
                  controller: widget.userProvider.workPassword,
                  obscureText: false,
                  textInputType: TextInputType.number,
                  maxLines: 1,
                  labelText: '暗証番号',
                  labelColor: Colors.black54,
                  prefixIconData: Icons.vpn_key,
                  suffixIconData: null,
                  onTap: null,
                ),
                SizedBox(height: 8.0),
                Text('※タブレットアプリ内で、このユーザーにログインするときに必要な暗証番号です。数字8桁以内でご入力ください。'),
                SizedBox(height: 16.0),
                RoundBackgroundButton(
                  onPressed: () async {
                    setState(() => _isLoading = true);
                    if (!await widget.userProvider.updateWorkPassword()) {
                      setState(() => _isLoading = false);
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => ErrorMessage('変更に失敗しました。'),
                      );
                      return;
                    }
                    widget.userProvider.clearController();
                    widget.userProvider.reloadUserModel();
                    setState(() => _isLoading = false);
                    Navigator.pop(context);
                  },
                  labelText: '変更を保存',
                  labelColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                SizedBox(height: 40.0),
              ],
            ),
    );
  }
}