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

  Future<void> workStart({
    GroupModel? group,
    UserModel? user,
    List<double>? locations,
    String? state,
  }) async {
    if (group == null) return;
    if (user == null) return;
    try {
      String _id = _workService.id();
      _workService.create({
        'id': _id,
        'groupId': group.id,
        'userId': user.id,
        'startedAt': DateTime.now(),
        'startedLat': locations!.first,
        'startedLon': locations.last,
        'endedAt': DateTime.now(),
        'endedLat': locations.first,
        'endedLon': locations.last,
        'breaks': [],
        'state': state,
        'createdAt': DateTime.now(),
      });
      int _workLv = 1;
      switch (state) {
        case '通常勤務':
          _workLv = 1;
          break;
        case '直行/直帰':
          _workLv = 2;
          break;
        case 'テレワーク':
          _workLv = 3;
          break;
      }
      _userService.update({
        'id': user.id,
        'workLv': _workLv,
        'lastWorkId': _id,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> workEnd({
    GroupModel? group,
    UserModel? user,
    List<double>? locations,
  }) async {
    if (group == null) return;
    if (user == null) return;
    try {
      WorkModel _work = await _workService.select(id: user.lastWorkId);
      if (_work.groupId != group.id) return;
      List<Map> _breaks = [];
      for (BreaksModel breaks in _work.breaks) {
        _breaks.add(breaks.toMap());
      }
      if (group.autoBreak == true) {
        String _id = randomString(20);
        _breaks.add({
          'id': _id,
          'startedAt': DateTime.now(),
          'startedLat': 0.0,
          'startedLon': 0.0,
          'endedAt': DateTime.now().add(Duration(hours: 1)),
          'endedLat': 0.0,
          'endedLon': 0.0,
        });
      }
      _workService.update({
        'id': user.lastWorkId,
        'endedAt': DateTime.now(),
        'endedLat': locations!.first,
        'endedLon': locations.last,
        'breaks': _breaks,
      });
      int _workLv = 0;
      _userService.update({
        'id': user.id,
        'workLv': _workLv,
        'lastWorkId': '',
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> breakStart({
    GroupModel? group,
    UserModel? user,
    List<double>? locations,
  }) async {
    if (group == null) return;
    if (user == null) return;
    try {
      WorkModel _work = await _workService.select(id: user.lastWorkId);
      if (_work.groupId != group.id) return;
      List<Map> _breaks = [];
      for (BreaksModel breaks in _work.breaks) {
        _breaks.add(breaks.toMap());
      }
      String _id = randomString(20);
      _breaks.add({
        'id': _id,
        'startedAt': DateTime.now(),
        'startedLat': locations!.first,
        'startedLon': locations.last,
        'endedAt': DateTime.now(),
        'endedLat': locations.first,
        'endedLon': locations.last,
      });
      _workService.update({
        'id': user.lastWorkId,
        'breaks': _breaks,
      });
      int _workLv = 91;
      switch (_work.state) {
        case '通常勤務':
          _workLv = 91;
          break;
        case '直行/直帰':
          _workLv = 92;
          break;
        case 'テレワーク':
          _workLv = 93;
          break;
      }
      _userService.update({
        'id': user.id,
        'workLv': _workLv,
        'lastBreakId': _id,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> breakEnd({
    GroupModel? group,
    UserModel? user,
    List<double>? locations,
  }) async {
    if (group == null) return;
    if (user == null) return;
    try {
      WorkModel _work = await _workService.select(id: user.lastWorkId);
      if (_work.groupId != group.id) return;
      List<Map> _breaks = [];
      for (BreaksModel breaks in _work.breaks) {
        if (breaks.id == user.lastBreakId) {
          breaks.endedAt = DateTime.now();
          breaks.endedLat = locations!.first;
          breaks.endedLon = locations.last;
        }
        _breaks.add(breaks.toMap());
      }
      _workService.update({
        'id': user.lastWorkId,
        'breaks': _breaks,
      });
      int _workLv = 1;
      switch (_work.state) {
        case '通常勤務':
          _workLv = 1;
          break;
        case '直行/直帰':
          _workLv = 2;
          break;
        case 'テレワーク':
          _workLv = 3;
          break;
      }
      _userService.update({
        'id': user.id,
        'workLv': _workLv,
        'lastBreakId': '',
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<WorkModel>> selectList({
    required GroupModel group,
    required UserModel user,
    required DateTime startAt,
    required DateTime endAt,
  }) async {
    List<WorkModel> _works = [];
    await _workService
        .selectList(
      groupId: group.id,
      userId: user.id,
      startAt: startAt,
      endAt: endAt,
    )
        .then((value) {
      _works = value;
    });
    return _works;
  }
}
