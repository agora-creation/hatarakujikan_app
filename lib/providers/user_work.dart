import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/models/user_work.dart';
import 'package:hatarakujikan_app/services/user.dart';
import 'package:hatarakujikan_app/services/user_work.dart';
import 'package:hatarakujikan_app/services/user_work_break.dart';
import 'package:intl/intl.dart';

class UserWorkProvider with ChangeNotifier {
  UserService _userService = UserService();
  UserWorkService _userWorkService = UserWorkService();
  UserWorkBreakService _userWorkBreakService = UserWorkBreakService();

  Future<bool> workStart({UserModel user, List<double> locations}) async {
    try {
      String _id = _userWorkService.id(userId: user.id);
      _userWorkService.create({
        'id': _id,
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
      _userWorkService.update({
        'id': user.lastWorkId,
        'userId': user.id,
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
      String _id =
          _userWorkBreakService.id(userId: user.id, workId: user.lastWorkId);
      _userWorkBreakService.create({
        'id': _id,
        'userId': user.id,
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
      _userWorkBreakService.update({
        'id': user.lastBreakId,
        'userId': user.id,
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

  Stream<QuerySnapshot> userWorkStream(
      {String userId, DateTime startAt, DateTime endAt}) {
    Timestamp _startAt = Timestamp.fromMillisecondsSinceEpoch(DateTime.parse(
            '${DateFormat('yyyy-MM-dd').format(startAt)} 00:00:00.000')
        .millisecondsSinceEpoch);
    Timestamp _endAt = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.parse('${DateFormat('yyyy-MM-dd').format(endAt)} 23:59:59.999')
            .millisecondsSinceEpoch);
    Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
        .collection('user')
        .doc(userId)
        .collection('work')
        .where('userId', isEqualTo: userId)
        .orderBy('startedAt', descending: false)
        .startAt([_startAt]).endAt([_endAt]).snapshots();
    return _stream;
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
