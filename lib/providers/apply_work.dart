import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/apply_work.dart';
import 'package:hatarakujikan_app/models/breaks.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/services/apply_work.dart';

class ApplyWorkProvider with ChangeNotifier {
  ApplyWorkService _applyWorkService = ApplyWorkService();

  Future<bool> create({
    UserModel? user,
    WorkModel? work,
    String? reason,
  }) async {
    if (user == null) return false;
    if (work == null) return false;
    try {
      String _id = _applyWorkService.id();
      List<Map> _breaks = [];
      for (BreaksModel breaks in work.breaks) {
        _breaks.add(breaks.toMap());
      }
      _applyWorkService.create({
        'id': _id,
        'workId': work.id,
        'groupId': work.groupId,
        'userId': work.userId,
        'userName': user.name,
        'endedAt': work.endedAt,
        'startedAt': work.startedAt,
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

  void delete({required ApplyWorkModel applyWork}) {
    _applyWorkService.delete({'id': applyWork.id});
  }
}
