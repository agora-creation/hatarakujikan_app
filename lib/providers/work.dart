import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/services/user.dart';
import 'package:hatarakujikan_app/services/work.dart';
import 'package:hatarakujikan_app/services/work_break.dart';

class WorkProvider with ChangeNotifier {
  UserService _userService = UserService();
  WorkService _workService = WorkService();
  WorkBreakService _workBreakService = WorkBreakService();

  Future<bool> workStart({UserModel user, List<double> locations}) async {
    try {
      String _id = _workService.id();
      _workService.create({
        'id': _id,
        'groupId': 'NO-DATA',
        'userId': user.id,
        'startedAt': DateTime.now(),
        'startedLat': locations.first,
        'startedLon': locations.last,
        'endedAt': DateTime.now(),
        'endedLat': locations.first,
        'endedLon': locations.last,
        'createdAt': DateTime.now(),
      });
      _userService.update({
        'id': user.id,
        'workLv': 1,
        'lastWorkId': _id,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> workEnd({UserModel user, List<double> locations}) async {
    try {
      _workService.update({
        'id': user.lastWorkId,
        'endedAt': DateTime.now(),
        'endedLat': locations.first,
        'endedLon': locations.last,
      });
      _userService.update({
        'id': user.id,
        'workLv': 0,
        'lastWorkId': '',
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> breakStart({UserModel user, List<double> locations}) async {
    try {
      String _id = _workBreakService.id(workId: user.lastWorkId);
      _workBreakService.create({
        'id': _id,
        'workId': user.lastWorkId,
        'startedAt': DateTime.now(),
        'startedLat': locations.first,
        'startedLon': locations.last,
        'endedAt': DateTime.now(),
        'endedLat': locations.first,
        'endedLon': locations.last,
        'createdAt': DateTime.now(),
      });
      _userService.update({
        'id': user.id,
        'workLv': 2,
        'lastBreakId': _id,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> breakEnd({UserModel user, List<double> locations}) async {
    try {
      _workBreakService.update({
        'id': user.lastBreakId,
        'workId': user.lastWorkId,
        'endedAt': DateTime.now(),
        'endedLat': locations.first,
        'endedLon': locations.last,
      });
      _userService.update({
        'id': user.id,
        'workLv': 1,
        'lastBreakId': '',
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<List<WorkModel>> selectList(
      {String userId, DateTime startAt, DateTime endAt}) async {
    List<WorkModel> _works = [];
    await _workService
        .selectList(userId: userId, startAt: startAt, endAt: endAt)
        .then((value) {
      _works = value;
    });
    return _works;
  }
}
