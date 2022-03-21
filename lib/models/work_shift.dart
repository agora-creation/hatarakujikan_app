import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WorkShiftModel {
  String _id = '';
  String _groupId = '';
  String _userId = '';
  DateTime _startedAt = DateTime.now();
  DateTime _endedAt = DateTime.now();
  String _state = '';
  DateTime _createdAt = DateTime.now();

  String get id => _id;
  String get groupId => _groupId;
  String get userId => _userId;
  DateTime get startedAt => _startedAt;
  DateTime get endedAt => _endedAt;
  String get state => _state;
  DateTime get createdAt => _createdAt;

  WorkShiftModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    _id = snapshot.data()!['id'] ?? '';
    _groupId = snapshot.data()!['groupId'] ?? '';
    _userId = snapshot.data()!['userId'] ?? '';
    _startedAt = snapshot.data()!['startedAt'].toDate() ?? DateTime.now();
    _endedAt = snapshot.data()!['endedAt'].toDate() ?? DateTime.now();
    _state = snapshot.data()!['state'] ?? '';
    _createdAt = snapshot.data()!['createdAt'].toDate() ?? DateTime.now();
  }

  Color stateColor() {
    switch (_state) {
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
