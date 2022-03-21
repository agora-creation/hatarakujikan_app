import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/services/group.dart';

class GroupProvider with ChangeNotifier {
  GroupService _groupService = GroupService();

  Future<bool> updatePrefs({required String groupId}) async {
    if (groupId == '') return false;
    try {
      await setPrefs(key: 'groupId', value: groupId);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateIn({
    required GroupModel group,
    required UserModel user,
  }) async {
    try {
      List<String> _userIds = [];
      _userIds = group.userIds;
      if (!_userIds.contains(user.id)) {
        _userIds.add(user.id);
      }
      print(_userIds);
      _groupService.update({
        'id': group.id,
        'userIds': _userIds,
      });
      await setPrefs(key: 'groupId', value: group.id);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateExit({
    required GroupModel group,
    required UserModel user,
  }) async {
    try {
      List<String> _userIds = [];
      _userIds = group.userIds;
      if (_userIds.contains(user.id)) {
        _userIds.remove(user.id);
      }
      _groupService.update({
        'id': group.id,
        'userIds': _userIds,
      });
      await removePrefs(key: 'groupId');
      List<GroupModel> _groups = [];
      await _groupService.selectListUser(userId: user.id).then((value) {
        _groups = value;
      });
      if (_groups.length > 0) {
        await setPrefs(key: 'groupId', value: _groups.first.id);
      }
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<GroupModel> select({required String id}) async {
    GroupModel? _group;
    await _groupService.select(id: id).then((value) {
      _group = value;
    });
    return _group!;
  }
}
