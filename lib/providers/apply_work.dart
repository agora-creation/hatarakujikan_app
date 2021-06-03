import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/apply_work.dart';
import 'package:hatarakujikan_app/models/breaks.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/services/apply_work.dart';

class ApplyWorkProvider with ChangeNotifier {
  ApplyWorkService _applyWorkService = ApplyWorkService();

  Future<bool> create({WorkModel work}) async {
    try {
      String _id = _applyWorkService.id();
      List<Map> _breaks = [];
      for (BreaksModel breaks in work?.breaks) {
        _breaks.add(breaks.toMap());
      }
      _applyWorkService.create({
        'id': _id,
        'workId': work.id,
        'groupId': work.groupId,
        'userId': work.userId,
        'startedAt': work.startedAt,
        'endedAt': work.endedAt,
        'breaks': _breaks,
        'createdAt': DateTime.now(),
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  void delete({ApplyWorkModel applyWork}) {
    _applyWorkService.delete({'id': applyWork.id});
  }
}
