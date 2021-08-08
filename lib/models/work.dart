import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/breaks.dart';
import 'package:hatarakujikan_app/models/group.dart';
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
    String _time = '00:00';
    String _startedDate = '${DateFormat('yyyy-MM-dd').format(startedAt)}';
    String _startedTime = '${startTime()}:00.000';
    DateTime _startedAt = DateTime.parse('$_startedDate $_startedTime');
    String _endedDate = '${DateFormat('yyyy-MM-dd').format(endedAt)}';
    String _endedTime = '${endTime()}:00.000';
    DateTime _endedAt = DateTime.parse('$_endedDate $_endedTime');
    // 出勤時間と退勤時間の差を求める
    Duration _diff = _endedAt.difference(_startedAt);
    String _minutes = twoDigits(_diff.inMinutes.remainder(60));
    _time = '${twoDigits(_diff.inHours)}:$_minutes';
    // 休憩の合計時間を求める
    String _breaksTime = '00:00';
    if (breaks.length > 0) {
      for (BreaksModel _break in breaks) {
        _breaksTime = addTime(_breaksTime, _break.breakTime());
      }
    }
    // 勤務時間と休憩の合計時間の差を求める
    _time = subTime(_time, _breaksTime);
    return _time;
  }

  //法定内時間/法定外時間
  List<String> legalTime(GroupModel group) {
    String _time = '00:00';
    String _nonTime = '00:00';
    List<String> _times = workTime().split(':');
    if (group.legal <= int.parse(_times.first)) {
      _time = addTime(_time, '0${group.legal}:00');
      String _tmp = subTime(workTime(), '0${group.legal}:00');
      _nonTime = addTime(_nonTime, _tmp);
    } else {
      _time = addTime(_time, workTime());
      _nonTime = addTime(_nonTime, '00:00');
    }
    return [_time, _nonTime];
  }

  //日中時間/深夜時間
  List<String> nightTime(GroupModel group) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String _dayTime = '00:00';
    String _nightTime = '00:00';
    String _startedDate = '${DateFormat('yyyy-MM-dd').format(startedAt)}';
    String _startedTime = '${startTime()}:00.000';
    DateTime _startedAt = DateTime.parse('$_startedDate $_startedTime');
    String _endedDate = '${DateFormat('yyyy-MM-dd').format(endedAt)}';
    String _endedTime = '${endTime()}:00.000';
    DateTime _endedAt = DateTime.parse('$_endedDate $_endedTime');
    // ----------------------------------------
    DateTime _dayS;
    DateTime _dayE;
    DateTime _nightS;
    DateTime _nightE;
    DateTime _baseSS =
        DateTime.parse('$_startedDate ${group.nightStart}:00.000');
    DateTime _baseSE = DateTime.parse('$_startedDate ${group.nightEnd}:00.000');
    DateTime _baseEE = DateTime.parse('$_endedDate ${group.nightEnd}:00.000');
    if (_startedAt.millisecondsSinceEpoch < _baseSS.millisecondsSinceEpoch &&
        _startedAt.millisecondsSinceEpoch > _baseSE.millisecondsSinceEpoch) {
      if (_endedAt.millisecondsSinceEpoch < _baseSE.millisecondsSinceEpoch &&
          _endedAt.millisecondsSinceEpoch > _baseEE.millisecondsSinceEpoch) {
        // 出勤時間[05:00〜22:00]退勤時間[05:00〜22:00]
        _dayS = _startedAt;
        _dayE = _endedAt;
        _nightS = _baseEE;
        _nightE = _baseEE;
      } else {
        // 出勤時間[05:00〜22:00]退勤時間[22:00〜05:00]
        _dayS = _startedAt;
        _dayE = _baseSE;
        _nightS = _baseSE;
        _nightE = _endedAt;
      }
    } else {
      if (_endedAt.millisecondsSinceEpoch < _baseSE.millisecondsSinceEpoch &&
          _endedAt.millisecondsSinceEpoch > _baseEE.millisecondsSinceEpoch) {
        // 出勤時間[22:00〜05:00]退勤時間[05:00〜22:00]
        _nightS = _startedAt;
        _nightE = _baseSE;
        _dayS = _baseSE;
        _dayE = _endedAt;
      } else {
        // 出勤時間[22:00〜05:00]退勤時間[22:00〜05:00]
        _dayS = _baseSS;
        _dayE = _baseSS;
        _nightS = _startedAt;
        _nightE = _endedAt;
      }
    }
    // ----------------------------------------
    if (_dayS.millisecondsSinceEpoch < _dayE.millisecondsSinceEpoch) {
      Duration _dayDiff = _dayE.difference(_dayS);
      String _dayMinutes = twoDigits(_dayDiff.inMinutes.remainder(60));
      _dayTime = '${twoDigits(_dayDiff.inHours)}:$_dayMinutes';
    } else {
      _dayTime = '00:00';
    }
    if (_nightS.millisecondsSinceEpoch < _nightE.millisecondsSinceEpoch) {
      Duration _nightDiff = _nightE.difference(_nightS);
      String _nightMinutes = twoDigits(_nightDiff.inMinutes.remainder(60));
      _nightTime = '${twoDigits(_nightDiff.inHours)}:$_nightMinutes';
    } else {
      _nightTime = '00:00';
    }
    return [_dayTime, _nightTime];
  }
}
