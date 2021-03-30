import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/services/user.dart';
import 'package:hatarakujikan_app/services/user_work.dart';
import 'package:hatarakujikan_app/services/user_work_break.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserWorkProvider with ChangeNotifier {
  UserService _userService = UserService();
  UserWorkService _userWorkService = UserWorkService();
  UserWorkBreakService _userWorkBreakService = UserWorkBreakService();

  Future<bool> createWorkStart({UserModel user}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      List<String> _location = _prefs.getStringList('location');
      String id = _userWorkService.newId(userId: user.id);
      _userWorkService.create({
        'id': id,
        'userId': user.id,
        'startedAt': DateTime.now(),
        'startedLon': double.parse(_location.first),
        'startedLat': double.parse(_location.last),
        'endedAt': DateTime.now(),
        'endedLon': double.parse(_location.first),
        'endedLat': double.parse(_location.last),
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
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      List<String> _location = _prefs.getStringList('location');
      _userWorkService.update({
        'id': user.workId,
        'userId': user.id,
        'endedAt': DateTime.now(),
        'endedLon': double.parse(_location.first),
        'endedLat': double.parse(_location.last),
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
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      List<String> _location = _prefs.getStringList('location');
      String id =
          _userWorkBreakService.newId(userId: user.id, workId: user.workId);
      _userWorkBreakService.create({
        'id': id,
        'userId': user.id,
        'workId': user.workId,
        'startedAt': DateTime.now(),
        'startedLon': double.parse(_location.first),
        'startedLat': double.parse(_location.last),
        'endedAt': DateTime.now(),
        'endedLon': double.parse(_location.first),
        'endedLat': double.parse(_location.last),
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
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      List<String> _location = _prefs.getStringList('location');
      _userWorkBreakService.update({
        'id': user.workBreakId,
        'userId': user.id,
        'workId': user.workId,
        'endedAt': DateTime.now(),
        'endedLon': double.parse(_location.first),
        'endedLat': double.parse(_location.last),
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
