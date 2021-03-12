import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/services/user_work.dart';

class UserWorkProvider with ChangeNotifier {
  UserWorkService _userWorkService = UserWorkService();

  void create({String userId}) {
    String id = _userWorkService.newId(userId: userId);
    _userWorkService.create({
      'id': id,
      'userId': userId,
      'startedAt': DateTime.now(),
      'startedLon': 0.0,
      'startedLat': 0.0,
      'endedAt': DateTime.now(),
      'endedLon': 0.0,
      'endedLat': 0.0,
      'createdAt': DateTime.now(),
    });
  }
}
