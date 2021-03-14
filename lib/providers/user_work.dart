import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/services/user.dart';
import 'package:hatarakujikan_app/services/user_work.dart';

class UserWorkProvider with ChangeNotifier {
  UserService _userService = UserService();
  UserWorkService _userWorkService = UserWorkService();

  Future<bool> createWorkStart({UserModel user}) async {
    try {
      String id = _userWorkService.newId(userId: user.id);
      _userWorkService.create({
        'id': id,
        'userId': user.id,
        'startedAt': DateTime.now(),
        'startedLon': 0.0,
        'startedLat': 0.0,
        'endedAt': DateTime.now(),
        'endedLon': 0.0,
        'endedLat': 0.0,
        'createdAt': DateTime.now(),
      });
      _userService.update({
        'id': user.id,
        'workId': id,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateWorkEnd({UserModel user}) async {
    try {
      _userWorkService.update({
        'id': user.workId,
        'userId': user.id,
        'endedAt': DateTime.now(),
        'endedLon': 0.0,
        'endedLat': 0.0,
      });
      _userService.update({
        'id': user.id,
        'workId': '',
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
