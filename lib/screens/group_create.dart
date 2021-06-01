import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/providers/group.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_app/widgets/error_message.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';

class GroupCreateScreen extends StatefulWidget {
  final GroupProvider groupProvider;
  final UserProvider userProvider;

  GroupCreateScreen({
    @required this.groupProvider,
    @required this.userProvider,
  });

  @override
  _GroupCreateScreenState createState() => _GroupCreateScreenState();
}

class _GroupCreateScreenState extends State<GroupCreateScreen> {
  bool _isLoading = false;
  List<int> _numList = [10, 50, 100];
  int _numSelected = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('会社/組織の作成申請'),
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
                  controller: widget.groupProvider.name,
                  obscureText: false,
                  textInputType: TextInputType.name,
                  maxLines: 1,
                  labelText: '会社/組織名',
                  labelColor: Colors.black54,
                  prefixIconData: Icons.store,
                  suffixIconData: null,
                  onTap: null,
                ),
                SizedBox(height: 8.0),
                Text('従業員数'),
                DropdownButton<int>(
                  isExpanded: true,
                  value: _numSelected,
                  onChanged: (value) {
                    setState(() => _numSelected = value);
                  },
                  items: _numList.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text('$e人未満'),
                    );
                  }).toList(),
                ),
                Text('※会社/組織アカウントを作成するための申請です。この申請は運営会社に送信されます。'),
                SizedBox(height: 16.0),
                RoundBackgroundButton(
                  onPressed: () async {
                    setState(() => _isLoading = true);
                    if (!await widget.groupProvider.sendMail(
                        user: widget.userProvider.user,
                        usersNum: _numSelected)) {
                      setState(() => _isLoading = false);
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => ErrorMessage('申請に失敗しました。'),
                      );
                      return;
                    }
                    widget.groupProvider.clearController();
                    setState(() => _isLoading = false);
                    Navigator.pop(context);
                  },
                  labelText: '作成申請する',
                  labelColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                SizedBox(height: 40.0),
              ],
            ),
    );
  }
}
