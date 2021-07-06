import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/services/group.dart';
import 'package:hatarakujikan_app/services/user.dart';

class GroupProvider with ChangeNotifier {
  GroupService _groupService = GroupService();
  UserService _userService = UserService();

  Future<bool> updatePrefs({String groupId}) async {
    if (groupId == '') return false;
    try {
      await setPrefs(groupId);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateIn({UserModel user, GroupModel group}) async {
    if (user == null) return false;
    if (group == null) return false;
    try {
      List<String> _groups = [];
      for (String _groupId in user?.groups) {
        _groups.add(_groupId);
      }
      _groups.add(group?.id);
      _userService.update({
        'id': user?.id,
        'groups': _groups,
      });
      await setPrefs(group?.id);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateExit({UserModel user, String groupId}) async {
    if (user == null) return false;
    if (groupId == '') return false;
    try {
      user.groups.removeWhere((e) => e == groupId);
      List<String> _groups = [];
      for (String _groupId in user?.groups) {
        _groups.add(_groupId);
      }
      _userService.update({
        'id': user?.id,
        'groups': _groups,
      });
      await setPrefs(_groups.first);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<GroupModel> select({String groupId}) async {
    GroupModel _group;
    await _groupService.select(groupId: groupId).then((value) {
      _group = value;
    });
    return _group;
  }
}
