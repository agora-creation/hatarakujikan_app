import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/models/user_work.dart';
import 'package:hatarakujikan_app/services/user.dart';
import 'package:hatarakujikan_app/services/user_work.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserWorkProvider with ChangeNotifier {
  UserService _userService = UserService();
  UserWorkService _userWorkService = UserWorkService();

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
        'breaks': [],
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

  Future<List<UserWorkModel>> selectList(
      {String userId, DateTime startAt, DateTime endAt}) async {
    List<UserWorkModel> _works = [];
    await _userWorkService
        .selectList(userId: userId, startAt: startAt, endAt: endAt)
        .then((value) {
      _works = value;
    });
    return _works;
  }
}
