import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/models/groups.dart';
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
        'createdAt': DateTime.now(),
      });
      List<Map> _groups = [];
      for (GroupsModel groups in user?.groups) {
        groups.fixed = false;
        _groups.add(groups.toMap());
      }
      _groups.add({
        'groupId': _id,
        'fixed': true,
      });
      _userService.update({
        'id': user.id,
        'groups': _groups,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateGroupFixed({UserModel user, String groupId}) async {
    if (user == null) return false;
    try {
      List<Map> _groups = [];
      for (GroupsModel groups in user?.groups) {
        groups.fixed = false;
        if (groups.groupId == groupId) {
          groups.fixed = true;
        }
        _groups.add(groups.toMap());
      }
      _userService.update({
        'id': user.id,
        'groups': _groups,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateGroupIn({UserModel user, String groupId}) async {
    if (user == null) return false;
    try {
      List<Map> _groups = [];
      for (GroupsModel groups in user?.groups) {
        groups.fixed = false;
        _groups.add(groups.toMap());
      }
      _groups.add({
        'groupId': groupId,
        'fixed': true,
      });
      _userService.update({
        'id': user.id,
        'groups': _groups,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateGroupsExit({UserModel user, String groupId}) async {
    if (user == null) return false;
    try {
      user.groups.removeWhere((e) => e.groupId == groupId);
      List<Map> _groups = [];
      int _i = 0;
      for (GroupsModel groups in user?.groups) {
        if (_i == 0) {
          groups.fixed = true;
        } else {
          groups.fixed = false;
        }
        _groups.add(groups.toMap());
        _i++;
      }
      _userService.update({
        'id': user.id,
        'groups': _groups,
      });
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
