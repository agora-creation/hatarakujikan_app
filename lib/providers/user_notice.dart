import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/user_notice.dart';
import 'package:hatarakujikan_app/services/user_notice.dart';

class UserNoticeProvider with ChangeNotifier {
  UserNoticeService _userNoticeService = UserNoticeService();

  void updateRead({UserNoticeModel? notice}) {
    _userNoticeService.update({
      'id': notice?.id,
      'userId': notice?.userId,
      'read': true,
    });
  }

  void delete({UserNoticeModel? notice}) {
    _userNoticeService.delete({
      'id': notice?.id,
      'userId': notice?.userId,
    });
  }

  Future<NotificationSettings> requestPermissions() async {
    NotificationSettings _settings =
        await FirebaseMessaging.instance.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );
    return _settings;
  }
}
