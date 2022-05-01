import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/services/apply_pto.dart';

class ApplyPTOProvider with ChangeNotifier {
  ApplyPTOService _applyPTOService = ApplyPTOService();

  Future<bool> create({
    GroupModel? group,
    UserModel? user,
    DateTime? startedAt,
    DateTime? endedAt,
    String? reason,
  }) async {
    if (group == null) return false;
    if (user == null) return false;
    if (startedAt == null) return false;
    if (endedAt == null) return false;
    try {
      String _id = _applyPTOService.id();
      _applyPTOService.create({
        'id': _id,
        'groupId': group.id,
        'userId': user.id,
        'userName': user.name,
        'startedAt': startedAt,
        'endedAt': endedAt,
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
      _applyPTOService.delete({'id': id});
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
        .collection('applyPTO')
        .where('groupId', isEqualTo: groupId ?? 'error')
        .where('userId', isEqualTo: userId ?? 'error')
        .where('approval', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots();
    return _ret;
  }
}
