import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/services/user.dart';
import 'package:hatarakujikan_app/services/user_work.dart';
import 'package:intl/intl.dart';

class UserWorkProvider with ChangeNotifier {
  UserService _userService = UserService();
  UserWorkService _userWorkService = UserWorkService();

  Future<bool> createWorkStart(
      {UserModel user, double longitude, double latitude}) async {
    try {
      String id = _userWorkService.newId(userId: user.id);
      _userWorkService.create({
        'id': id,
        'userId': user.id,
        'startedAt': DateTime.now(),
        'startedLat': latitude,
        'startedLon': longitude,
        'endedAt': DateTime.now(),
        'endedLat': latitude,
        'endedLon': longitude,
        'breaks': [],
        'createdAt': DateTime.now(),
      });
      _userService.update({
        'id': user.id,
        'workLv': 1,
        'lastWorkId': id,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateWorkEnd(
      {UserModel user, double longitude, double latitude}) async {
    try {
      _userWorkService.update({
        'id': user.lastWorkId,
        'userId': user.id,
        'endedAt': DateTime.now(),
        'endedLat': latitude,
        'endedLon': longitude,
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
}
