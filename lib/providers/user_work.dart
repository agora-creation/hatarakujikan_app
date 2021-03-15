import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/services/user.dart';
import 'package:hatarakujikan_app/services/user_work.dart';
import 'package:hatarakujikan_app/services/user_work_break.dart';

class UserWorkProvider with ChangeNotifier {
  UserService _userService = UserService();
  UserWorkService _userWorkService = UserWorkService();
  UserWorkBreakService _userWorkBreakService = UserWorkBreakService();

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

  Future<bool> createWorkBreakStart({UserModel user}) async {
    try {
      String id =
          _userWorkBreakService.newId(userId: user.id, workId: user.workId);
      _userWorkBreakService.create({
        'id': id,
        'userId': user.id,
        'workId': user.workId,
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
        'workBreakId': id,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateWorkBreakEnd({UserModel user}) async {
    try {
      _userWorkBreakService.update({
        'id': user.workBreakId,
        'userId': user.id,
        'workId': user.workId,
        'endedAt': DateTime.now(),
        'endedLon': 0.0,
        'endedLat': 0.0,
      });
      _userService.update({
        'id': user.id,
        'workBreakId': '',
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
