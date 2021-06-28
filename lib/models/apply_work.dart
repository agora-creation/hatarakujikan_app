import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_app/models/breaks.dart';

class ApplyWorkModel {
  String _id;
  String _workId;
  String _groupId;
  String _userId;
  String _userName;
  DateTime _startedAt;
  DateTime _endedAt;
  List<BreaksModel> breaks;
  String _reason;
  bool _approval;
  DateTime _createdAt;

  String get id => _id;
  String get workId => _workId;
  String get groupId => _groupId;
  String get userId => _userId;
  String get userName => _userName;
  DateTime get startedAt => _startedAt;
  DateTime get endedAt => _endedAt;
  String get reason => _reason;
  bool get approval => _approval;
  DateTime get createdAt => _createdAt;

  ApplyWorkModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()['id'];
    _workId = snapshot.data()['workId'];
    _groupId = snapshot.data()['groupId'];
    _userId = snapshot.data()['userId'];
    _userName = snapshot.data()['userName'];
    _startedAt = snapshot.data()['startedAt'].toDate();
    _endedAt = snapshot.data()['endedAt'].toDate();
    breaks = _convertBreaks(snapshot.data()['breaks']) ?? [];
    _reason = snapshot.data()['reason'] ?? '';
    _approval = snapshot.data()['approval'];
    _createdAt = snapshot.data()['createdAt'].toDate();
  }

  List<BreaksModel> _convertBreaks(List breaks) {
    List<BreaksModel> converted = [];
    for (Map data in breaks) {
      converted.add(BreaksModel.fromMap(data));
    }
    return converted;
  }
}
