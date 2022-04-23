import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/services/user_notice.dart';

class UserNoticeProvider with ChangeNotifier {
  UserNoticeService _userNoticeService = UserNoticeService();

  Future<bool> update({
    String? id,
    String? userId,
  }) async {
    if (id == null) return false;
    if (userId == null) return false;
    try {
      _userNoticeService.update({
        'id': id,
        'userId': userId,
        'read': true,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> delete({
    String? id,
    String? userId,
  }) async {
    if (id == null) return false;
    if (userId == null) return false;
    try {
      _userNoticeService.delete({
        'id': id,
        'userId': userId,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
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

  Stream<QuerySnapshot<Map<String, dynamic>>>? streamList({String? userId}) {
    Stream<QuerySnapshot<Map<String, dynamic>>>? _ret;
    _ret = FirebaseFirestore.instance
        .collection('user')
        .doc(userId ?? 'error')
        .collection('notice')
        .orderBy('createdAt', descending: true)
        .snapshots();
    return _ret;
  }
}
