import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/services/group.dart';
import 'package:hatarakujikan_app/services/user.dart';

class GroupProvider with ChangeNotifier {
  GroupService _groupService = GroupService();
  UserService _userService = UserService();

  TextEditingController name = TextEditingController();

  Future<bool> updatePrefs({String groupId}) async {
    try {
      await setPrefs(groupId);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateIn({UserModel user, String groupId}) async {
    if (user == null) return false;
    try {
      List<String> _groups = [];
      for (String _groupId in user?.groups) {
        _groups.add(_groupId);
      }
      _groups.add(groupId);
      _userService.update({
        'id': user.id,
        'groups': _groups,
      });
      await setPrefs(groupId);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateExit({UserModel user, String groupId}) async {
    if (user == null) return false;
    try {
      user.groups.removeWhere((e) => e == groupId);
      List<String> _groups = [];
      for (String _groupId in user?.groups) {
        _groups.add(_groupId);
      }
      _userService.update({
        'id': user.id,
        'groups': _groups,
      });
      await setPrefs(_groups.first);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> sendMail({UserModel user, int usersNum}) async {
    if (name.text == null) return false;
    String body = 'はたらくじかんforスマートフォンから会社/組織の作成申請がありました。¥n';
    body += '会社/組織名: ${name.text.trim()}¥n';
    body += '従業員数: $usersNum人未満¥n';
    body += '申請者名: ${user.name}¥n';
    body += '申請者メールアドレス: ${user.email}¥n';
    String subject = '【はたらくじかんforスマートフォン】会社/組織の作成申請';
    try {
      final Email email = Email(
        body: body,
        subject: subject,
        recipients: ['info@agora-c.com'],
        isHTML: false,
      );
      await FlutterEmailSender.send(email);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  void clearController() {
    name.text = '';
  }

  Future<GroupModel> select({String groupId}) async {
    GroupModel _group;
    await _groupService.select(groupId: groupId).then((value) {
      _group = value;
    });
    return _group;
  }
}
