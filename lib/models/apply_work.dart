import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_app/models/breaks.dart';

class ApplyWorkModel {
  String _id = '';
  String _workId = '';
  String _groupId = '';
  String _userId = '';
  String _userName = '';
  DateTime startedAt = DateTime.now();
  DateTime endedAt = DateTime.now();
  List<BreaksModel> breaks = [];
  String reason = '';
  bool _approval = false;
  DateTime _createdAt = DateTime.now();

  String get id => _id;
  String get workId => _workId;
  String get groupId => _groupId;
  String get userId => _userId;
  String get userName => _userName;
  bool get approval => _approval;
  DateTime get createdAt => _createdAt;

  ApplyWorkModel.set(Map data) {
    _id = data['id'] ?? '';
    _workId = data['groupId'] ?? '';
    _groupId = data['groupId'] ?? '';
    _userId = data['userId'] ?? '';
    _userName = data['userName'] ?? '';
    startedAt = data['startedAt'] ?? DateTime.now();
    endedAt = data['endedAt'] ?? DateTime.now();
    breaks = data['breaks'] ?? [];
    reason = data['reason'] ?? '';
    _approval = data['approval'] ?? false;
    _createdAt = data['createdAt'] ?? DateTime.now();
  }

  ApplyWorkModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    _id = snapshot.data()!['id'] ?? '';
    _workId = snapshot.data()!['workId'] ?? '';
    _groupId = snapshot.data()!['groupId'] ?? '';
    _userId = snapshot.data()!['userId'] ?? '';
    _userName = snapshot.data()!['userName'] ?? '';
    startedAt = snapshot.data()!['startedAt'].toDate() ?? DateTime.now();
    endedAt = snapshot.data()!['endedAt'].toDate() ?? DateTime.now();
    breaks = _convertBreaks(snapshot.data()!['breaks']);
    reason = snapshot.data()!['reason'] ?? '';
    _approval = snapshot.data()!['approval'] ?? false;
    _createdAt = snapshot.data()!['createdAt'].toDate() ?? DateTime.now();
  }

  List<BreaksModel> _convertBreaks(List list) {
    List<BreaksModel> converted = [];
    for (Map data in list) {
      converted.add(BreaksModel.fromMap(data));
    }
    return converted;
  }
}
