import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WorkShiftModel {
  String _id = '';
  String _groupId = '';
  String userId = '';
  DateTime startedAt = DateTime.now();
  DateTime endedAt = DateTime.now();
  String state = '';
  DateTime _createdAt = DateTime.now();

  String get id => _id;
  String get groupId => _groupId;
  DateTime get createdAt => _createdAt;

  WorkShiftModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    _id = snapshot.data()!['id'] ?? '';
    _groupId = snapshot.data()!['groupId'] ?? '';
    userId = snapshot.data()!['userId'] ?? '';
    startedAt = snapshot.data()!['startedAt'].toDate() ?? DateTime.now();
    endedAt = snapshot.data()!['endedAt'].toDate() ?? DateTime.now();
    state = snapshot.data()!['state'] ?? '';
    _createdAt = snapshot.data()!['createdAt'].toDate() ?? DateTime.now();
  }

  Color stateColor() {
    switch (state) {
      case '勤務予定':
        return Colors.lightBlue.shade300;
      case '欠勤':
        return Colors.red.shade300;
      case '特別休暇':
        return Colors.green.shade300;
      case '有給休暇':
        return Colors.teal.shade300;
      case '代休':
        return Colors.pink.shade300;
      default:
        return Colors.red.shade300;
    }
  }
}
