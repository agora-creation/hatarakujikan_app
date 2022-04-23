import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/apply_work.dart';
import 'package:hatarakujikan_app/models/breaks.dart';
import 'package:hatarakujikan_app/services/apply_work.dart';

class ApplyWorkProvider with ChangeNotifier {
  ApplyWorkService _applyWorkService = ApplyWorkService();

  Future<bool> create({ApplyWorkModel? applyWork}) async {
    if (applyWork == null) return false;
    try {
      String _id = _applyWorkService.id();
      List<Map> _breaks = [];
      for (BreaksModel breaksModel in applyWork.breaks) {
        _breaks.add(breaksModel.toMap());
      }
      _applyWorkService.create({
        'id': _id,
        'workId': applyWork.workId,
        'groupId': applyWork.groupId,
        'userId': applyWork.userId,
        'userName': applyWork.userName,
        'startedAt': applyWork.startedAt,
        'endedAt': applyWork.endedAt,
        'breaks': _breaks,
        'reason': applyWork.reason,
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
