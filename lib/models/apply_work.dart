import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_app/models/breaks.dart';

class ApplyWorkModel {
  String _id;
  String _groupId;
  String _userId;
  String _workId;
  DateTime _startedAt;
  double _startedLat;
  double _startedLon;
  DateTime _endedAt;
  double _endedLat;
  double _endedLon;
  List<BreaksModel> breaks;
  DateTime _createdAt;

  String get id => _id;
  String get groupId => _groupId;
  String get userId => _userId;
  String get workId => _workId;
  DateTime get startedAt => _startedAt;
  double get startedLat => _startedLat;
  double get startedLon => _startedLon;
  DateTime get endedAt => _endedAt;
  double get endedLat => _endedLat;
  double get endedLon => _endedLon;
  DateTime get createdAt => _createdAt;

  ApplyWorkModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()['id'];
    _groupId = snapshot.data()['groupId'];
    _userId = snapshot.data()['userId'];
    _workId = snapshot.data()['workId'];
    _startedAt = snapshot.data()['startedAt'].toDate();
    _startedLat = snapshot.data()['startedLat'];
    _startedLon = snapshot.data()['startedLon'];
    _endedAt = snapshot.data()['endedAt'].toDate();
    _endedLat = snapshot.data()['endedLat'];
    _endedLon = snapshot.data()['endedLon'];
    breaks = _convertBreaks(snapshot.data()['breaks']) ?? [];
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
