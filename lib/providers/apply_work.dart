import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/breaks.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/services/apply_work.dart';
import 'package:hatarakujikan_app/services/user.dart';

class ApplyWorkProvider with ChangeNotifier {
  ApplyWorkService _applyWorkService = ApplyWorkService();
  UserService _userService = UserService();

  Future<bool> create({
    WorkModel? work,
    List<BreaksModel>? breaks,
    String? reason,
  }) async {
    if (work == null) return false;
    if (breaks == null) return false;
    UserModel? _user = await _userService.select(id: work.userId);
    if (_user == null) return false;
    try {
      String _id = _applyWorkService.id();
      List<Map> _breaks = [];
      for (BreaksModel _breaksModel in breaks) {
        _breaks.add(_breaksModel.toMap());
      }
      _applyWorkService.create({
        'id': _id,
        'workId': work.id,
        'groupId': work.groupId,
        'userId': work.userId,
        'userName': _user.name,
        'startedAt': work.startedAt,
        'endedAt': work.endedAt,
        'breaks': _breaks,
        'reason': reason,
        'approval': false,
        'createdAt': DateTime.now(),
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> delete({String? id}) async {
    if (id == null) return false;
    try {
      _applyWorkService.delete({'id': id});
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? streamList({
    String? groupId,
    String? userId,
  }) {
    Stream<QuerySnapshot<Map<String, dynamic>>>? _ret;
    _ret = FirebaseFirestore.instance
        .collection('applyWork')
        .where('groupId', isEqualTo: groupId ?? 'error')
        .where('userId', isEqualTo: userId ?? 'error')
        .where('approval', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots();
    return _ret;
  }
}
