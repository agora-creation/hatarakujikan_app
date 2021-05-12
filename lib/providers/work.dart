import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/breaks.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/services/user.dart';
import 'package:hatarakujikan_app/services/work.dart';

class WorkProvider with ChangeNotifier {
  UserService _userService = UserService();
  WorkService _workService = WorkService();

  Future<bool> workStart(
      {GroupModel group, UserModel user, List<double> locations}) async {
    try {
      String _id = _workService.id();
      _workService.create({
        'id': _id,
        'groupId': group.id,
        'userId': user.id,
        'startedAt': DateTime.now(),
        'startedLat': locations.first,
        'startedLon': locations.last,
        'endedAt': DateTime.now(),
        'endedLat': locations.first,
        'endedLon': locations.last,
        'breaks': [],
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

  Future<bool> workEnd(
      {GroupModel group, UserModel user, List<double> locations}) async {
    try {
      WorkModel _work = await _workService.select(workId: user.lastWorkId);
      if (_work.groupId != group.id) {
        return false;
      }
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

  Future<bool> breakStart(
      {GroupModel group, UserModel user, List<double> locations}) async {
    try {
      WorkModel _work = await _workService.select(workId: user.lastWorkId);
      if (_work.groupId != group.id) {
        return false;
      }
      List<Map> _breaks = [];
      for (BreaksModel breaks in _work?.breaks) {
        _breaks.add(breaks.toMap());
      }
      String _id = randomString(20);
      _breaks.add({
        'id': _id,
        'startedAt': DateTime.now(),
        'startedLat': locations.first,
        'startedLon': locations.last,
        'endedAt': DateTime.now(),
        'endedLat': locations.first,
        'endedLon': locations.last,
      });
      _workService.update({
        'id': user.lastWorkId,
        'breaks': _breaks,
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

  Future<bool> breakEnd(
      {GroupModel group, UserModel user, List<double> locations}) async {
    try {
      WorkModel _work = await _workService.select(workId: user.lastWorkId);
      if (_work.groupId != group.id) {
        return false;
      }
      List<Map> _breaks = [];
      for (BreaksModel breaks in _work?.breaks) {
        if (breaks.id == user?.lastBreakId) {
          breaks.endedAt = DateTime.now();
          breaks.endedLat = locations.first;
          breaks.endedLon = locations.last;
        }
        _breaks.add(breaks.toMap());
      }
      _workService.update({
        'id': user.lastWorkId,
        'breaks': _breaks,
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
      {String groupId, String userId, DateTime startAt, DateTime endAt}) async {
    List<WorkModel> _works = [];
    await _workService
        .selectList(
            groupId: groupId, userId: userId, startAt: startAt, endAt: endAt)
        .then((value) {
      _works = value;
    });
    return _works;
  }
}
