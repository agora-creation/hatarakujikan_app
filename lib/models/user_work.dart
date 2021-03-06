import 'package:cloud_firestore/cloud_firestore.dart';

class UserWork {
  String _id;
  String _userId;
  DateTime _startedAt;
  double _startedLon;
  double _startedLat;
  DateTime _endedAt;
  double _endedLon;
  double _endedLat;
  DateTime _createdAt;

  String get id => _id;
  String get userId => _userId;
  DateTime get startedAt => _startedAt;
  double get startedLon => _startedLon;
  double get startedLat => _startedLat;
  DateTime get endedAt => _endedAt;
  double get endedLon => _endedLon;
  double get endedLat => _endedLat;
  DateTime get createdAt => _createdAt;

  UserWork.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()['id'];
    _userId = snapshot.data()['userId'];
    _startedAt = snapshot.data()['startedAt'].toDate();
    _startedLon = snapshot.data()['startedLon'];
    _startedLat = snapshot.data()['startedLat'];
    _endedAt = snapshot.data()['endedAt'].toDate();
    _endedLon = snapshot.data()['endedLon'];
    _endedLat = snapshot.data()['endedLat'];
    _createdAt = snapshot.data()['createdAt'].toDate();
  }
}
