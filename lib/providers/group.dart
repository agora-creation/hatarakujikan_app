import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/services/group.dart';

class GroupProvider with ChangeNotifier {
  GroupService _groupService = GroupService();

  Future<bool> updatePrefs({String? groupId}) async {
    if (groupId == null) return false;
    try {
      await setPrefs('groupId', groupId);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateIn({
    GroupModel? group,
    UserModel? user,
  }) async {
    if (group == null) return false;
    if (user == null) return false;
    try {
      List<String> userIds = group.userIds;
      if (!userIds.contains(user.id)) {
        userIds.add(user.id);
      }
      _groupService.update({
        'id': group.id,
        'userIds': userIds,
      });
      await setPrefs('groupId', group.id);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateExit({
    GroupModel? group,
    UserModel? user,
  }) async {
    if (group == null) return false;
    if (user == null) return false;
    try {
      List<String> userIds = group.userIds;
      if (userIds.contains(user.id)) {
        userIds.remove(user.id);
      }
      _groupService.update({
        'id': group.id,
        'userIds': userIds,
      });
      await removePrefs('groupId');
      List<GroupModel> _groups = await _groupService.selectListUser(
        userId: user.id,
      );
      if (_groups.length > 0) {
        await setPrefs('groupId', _groups.first.id);
      }
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<GroupModel?> select({String? id}) async {
    GroupModel? _group;
    await _groupService.select(id: id).then((value) {
      _group = value;
    });
    return _group;
  }
}
