import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/user_notice.dart';
import 'package:hatarakujikan_app/services/user_notice.dart';

class UserNoticeProvider with ChangeNotifier {
  UserNoticeService _userNoticeService = UserNoticeService();

  void updateRead({UserNoticeModel notice}) {
    _userNoticeService.update({
      'id': notice.id,
      'userId': notice.userId,
      'read': true,
    });
  }
}
