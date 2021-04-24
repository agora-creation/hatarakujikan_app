import 'package:cloud_firestore/cloud_firestore.dart';

class UserWorkBreakModel {
  String _id;
  String _userId;
  String _workId;
  DateTime _startedAt;
  double _startedLat;
  double _startedLon;
  DateTime _endedAt;
  double _endedLat;
  double _endedLon;
  DateTime _createdAt;

  String get id => _id;
  String get userId => _userId;
  String get workId => _workId;
  DateTime get startedAt => _startedAt;
  double get startedLat => _startedLat;
  double get startedLon => _startedLon;
  DateTime get endedAt => _endedAt;
  double get endedLat => _endedLat;
  double get endedLon => _endedLon;
  DateTime get createdAt => _createdAt;

  UserWorkBreakModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()['id'];
    _userId = snapshot.data()['userId'];
    _workId = snapshot.data()['workId'];
    _startedAt = snapshot.data()['startedAt'].toDate();
    _startedLat = snapshot.data()['startedLat'];
    _startedLon = snapshot.data()['startedLon'];
    _endedAt = snapshot.data()['endedAt'].toDate();
    _endedLat = snapshot.data()['endedLat'];
    _endedLon = snapshot.data()['endedLon'];
    _createdAt = snapshot.data()['createdAt'].toDate();
  }

  String diffTime() {
    Duration _diff = _endedAt.difference(_startedAt);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(_diff.inMinutes.remainder(60));
    return '${twoDigits(_diff.inHours)}:$twoDigitMinutes';
  }
}
