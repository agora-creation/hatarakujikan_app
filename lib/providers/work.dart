import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/breaks.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/services/log.dart';
import 'package:hatarakujikan_app/services/user.dart';
import 'package:hatarakujikan_app/services/work.dart';

class WorkProvider with ChangeNotifier {
  LogService _logService = LogService();
  UserService _userService = UserService();
  WorkService _workService = WorkService();

  Future<bool> workStart({
    GroupModel? group,
    UserModel? user,
    List<double>? locations,
    String? state,
  }) async {
    if (group == null) return false;
    if (user == null) return false;
    if (state == null) return false;
    String _id = _workService.id();
    if (_id == '') return false;
    try {
      _workService.create({
        'id': _id,
        'groupId': group.id,
        'userId': user.id,
        'startedAt': DateTime.now(),
        'startedLat': locations?.first ?? 0,
        'startedLon': locations?.last ?? 0,
        'endedAt': DateTime.now(),
        'endedLat': locations?.first ?? 0,
        'endedLon': locations?.last ?? 0,
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
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> workEnd({
    GroupModel? group,
    UserModel? user,
    List<double>? locations,
  }) async {
    if (group == null) return false;
    if (user == null) return false;
    if (user.lastWorkId == '') return false;
    WorkModel? _work = await _workService.select(id: user.lastWorkId);
    if (_work?.groupId != group.id) return false;
    if (_work?.userId != user.id) return false;
    try {
      List<Map> _breaks = [];
      for (BreaksModel _breaksModel in _work?.breaks ?? []) {
        _breaks.add(_breaksModel.toMap());
      }
      if (group.autoBreak == true) {
        String _breaksId = randomString(20);
        _breaks.add({
          'id': _breaksId,
          'startedAt': DateTime.now(),
          'startedLat': 0.0,
          'startedLon': 0.0,
          'endedAt': DateTime.now().add(Duration(hours: 1)),
          'endedLat': 0.0,
          'endedLon': 0.0,
        });
      }
      _workService.update({
        'id': _work?.id,
        'endedAt': DateTime.now(),
        'endedLat': locations?.first ?? 0,
        'endedLon': locations?.last ?? 0,
        'breaks': _breaks,
      });
      _userService.update({
        'id': user.id,
        'workLv': 0,
        'lastWorkId': '',
      });
      String _logId = _logService.id();
      String d = '';
      d += '[出勤] ${dateText('yyyy/MM/dd HH:mm', _work?.startedAt)}\n';
      d += '[退勤] ${dateText('yyyy/MM/dd HH:mm', _work?.endedAt)}\n';
      for (BreaksModel _breaksModel in _work?.breaks ?? []) {
        d += '[休憩開始] ${dateText('yyyy/MM/dd HH:mm', _breaksModel.startedAt)}\n';
        d += '[休憩終了] ${dateText('yyyy/MM/dd HH:mm', _breaksModel.endedAt)}\n';
      }
      _logService.create({
        'id': _logId,
        'groupId': _work?.groupId,
        'userId': _work?.userId,
        'userName': user.name,
        'workId': _work?.id,
        'title': '勤怠データを記録しました',
        'details': d.trim(),
        'createdAt': DateTime.now(),
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> breakStart({
    GroupModel? group,
    UserModel? user,
    List<double>? locations,
  }) async {
    if (group == null) return false;
    if (user == null) return false;
    if (user.lastWorkId == '') return false;
    WorkModel? _work = await _workService.select(id: user.lastWorkId);
    if (_work?.groupId != group.id) return false;
    if (_work?.userId != user.id) return false;
    try {
      List<Map> _breaks = [];
      for (BreaksModel _breaksModel in _work?.breaks ?? []) {
        _breaks.add(_breaksModel.toMap());
      }
      String _breaksId = randomString(20);
      _breaks.add({
        'id': _breaksId,
        'startedAt': DateTime.now(),
        'startedLat': locations?.first ?? 0,
        'startedLon': locations?.last ?? 0,
        'endedAt': DateTime.now(),
        'endedLat': locations?.first ?? 0,
        'endedLon': locations?.last ?? 0,
      });
      _workService.update({
        'id': _work?.id,
        'breaks': _breaks,
      });
      int _workLv = 91;
      switch (_work?.state) {
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
        'lastBreakId': _breaksId,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> breakEnd({
    GroupModel? group,
    UserModel? user,
    List<double>? locations,
  }) async {
    if (group == null) return false;
    if (user == null) return false;
    if (user.lastWorkId == '') return false;
    if (user.lastBreakId == '') return false;
    WorkModel? _work = await _workService.select(id: user.lastWorkId);
    if (_work?.groupId != group.id) return false;
    if (_work?.userId != user.id) return false;
    try {
      List<Map> _breaks = [];
      for (BreaksModel _breaksModel in _work?.breaks ?? []) {
        if (_breaksModel.id == user.lastBreakId) {
          _breaksModel.endedAt = DateTime.now();
          _breaksModel.endedLat = locations?.first ?? 0;
          _breaksModel.endedLon = locations?.last ?? 0;
        }
        _breaks.add(_breaksModel.toMap());
      }
      _workService.update({
        'id': _work?.id,
        'breaks': _breaks,
      });
      int _workLv = 1;
      switch (_work?.state) {
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
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<List<WorkModel>> selectList({
    GroupModel? group,
    UserModel? user,
    DateTime? startAt,
    DateTime? endAt,
  }) async {
    List<WorkModel> _works = [];
    await _workService
        .selectList(
      groupId: group?.id,
      userId: user?.id,
      startAt: startAt,
      endAt: endAt,
    )
        .then((value) {
      _works = value;
    });
    return _works;
  }

  DateTime month = DateTime.now();
  List<DateTime> days = generateDays(DateTime.now());

  void changeMonth(DateTime value) {
    month = value;
    days = generateDays(month);
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? streamList({
    String? groupId,
    String? userId,
  }) {
    Stream<QuerySnapshot<Map<String, dynamic>>>? _ret;
    Timestamp _startAt = convertTimestamp(days.first, false);
    Timestamp _endAt = convertTimestamp(days.last, true);
    _ret = FirebaseFirestore.instance
        .collection('work')
        .where('groupId', isEqualTo: groupId ?? 'error')
        .where('userId', isEqualTo: userId ?? 'error')
        .orderBy('startedAt', descending: false)
        .startAt([_startAt]).endAt([_endAt]).snapshots();
    return _ret;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? streamListShift({
    String? groupId,
    String? userId,
  }) {
    Stream<QuerySnapshot<Map<String, dynamic>>>? _ret;
    Timestamp _startAt = convertTimestamp(days.first, false);
    Timestamp _endAt = convertTimestamp(days.last, true);
    _ret = FirebaseFirestore.instance
        .collection('workShift')
        .where('groupId', isEqualTo: groupId ?? 'error')
        .where('userId', isEqualTo: userId ?? 'error')
        .orderBy('startedAt', descending: false)
        .startAt([_startAt]).endAt([_endAt]).snapshots();
    return _ret;
  }
}
