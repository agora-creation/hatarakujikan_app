import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/services/group.dart';
import 'package:hatarakujikan_app/services/user.dart';

class GroupProvider with ChangeNotifier {
  GroupService _groupService = GroupService();
  UserService _userService = UserService();

  TextEditingController name = TextEditingController();

  Future<bool> create({UserModel user}) async {
    if (name.text == null) return false;
    if (user == null) return false;
    try {
      String _id = _groupService.id();
      _groupService.create({
        'id': _id,
        'name': name.text.trim(),
        'adminUserId': user.id,
        'usersNum': 50,
        'createdAt': DateTime.now(),
      });
      List<String> _groups = [];
      for (String _groupId in user?.groups) {
        _groups.add(_groupId);
      }
      _groups.add(_id);
      _userService.update({
        'id': user.id,
        'groups': _groups,
      });
      await setPrefs(_id);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

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
