import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/groups.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/services/group.dart';
import 'package:hatarakujikan_app/services/user.dart';

class GroupProvider with ChangeNotifier {
  GroupService _groupService = GroupService();
  UserService _userService = UserService();

  TextEditingController name = TextEditingController();

  Future<bool> create({UserModel user}) async {
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

  void clearController() {
    name.text = '';
  }
}
