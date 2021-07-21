import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/breaks.dart';
import 'package:intl/intl.dart';

class WorkModel {
  String _id;
  String _groupId;
  String _userId;
  DateTime startedAt;
  double startedLat;
  double startedLon;
  String startedDev;
  DateTime endedAt;
  double endedLat;
  double endedLon;
  String endedDev;
  List<BreaksModel> breaks;
  String _state;
  DateTime _createdAt;

  String get id => _id;
  String get groupId => _groupId;
  String get userId => _userId;
  String get state => _state;
  DateTime get createdAt => _createdAt;

  WorkModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()['id'];
    _groupId = snapshot.data()['groupId'];
    _userId = snapshot.data()['userId'];
    startedAt = snapshot.data()['startedAt'].toDate();
    startedLat = snapshot.data()['startedLat'].toDouble();
    startedLon = snapshot.data()['startedLon'].toDouble();
    startedDev = snapshot.data()['startedDev'] ?? '';
    endedAt = snapshot.data()['endedAt'].toDate();
    endedLat = snapshot.data()['endedLat'].toDouble();
    endedLon = snapshot.data()['endedLon'].toDouble();
    endedDev = snapshot.data()['endedDev'] ?? '';
    breaks = _convertBreaks(snapshot.data()['breaks']) ?? [];
    _state = snapshot.data()['state'] ?? '';
    _createdAt = snapshot.data()['createdAt'].toDate();
  }

  List<BreaksModel> _convertBreaks(List breaks) {
    List<BreaksModel> converted = [];
    for (Map data in breaks) {
      converted.add(BreaksModel.fromMap(data));
    }
    return converted;
  }

  String startTime() {
    String _time = '${DateFormat('HH:mm').format(startedAt)}';
    return _time;
  }

  String endTime() {
    String _time = '${DateFormat('HH:mm').format(endedAt)}';
    return _time;
  }

  String breakTime() {
    String _time = '00:00';
    if (breaks.length > 0) {
      for (BreaksModel _break in breaks) {
        _time = addTime(_time, _break.breakTime());
      }
    }
    return _time;
  }

  String workTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    // 出勤時間と退勤時間の差を求める
    Duration _diff = endedAt.difference(startedAt);
    String _minutes = twoDigits(_diff.inMinutes.remainder(60));
    String _workTime = '${twoDigits(_diff.inHours)}:$_minutes';
    // 休憩の合計時間を求める
    String _breaksTime = '00:00';
    if (breaks.length > 0) {
      for (BreaksModel _break in breaks) {
        _breaksTime = addTime(_breaksTime, _break.breakTime());
      }
    }
    // 勤務時間と休憩の合計時間の差を求める
    _workTime = subTime(_workTime, _breaksTime);
    return _workTime;
  }
}
