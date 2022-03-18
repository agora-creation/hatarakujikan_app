import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/breaks.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:intl/intl.dart';

class WorkModel {
  String? _id;
  String? _groupId;
  String? _userId;
  DateTime? startedAt;
  double? startedLat;
  double? startedLon;
  DateTime? endedAt;
  double? endedLat;
  double? endedLon;
  List<BreaksModel> breaks = [];
  String? _state;
  DateTime? _createdAt;

  String? get id => _id;
  String? get groupId => _groupId;
  String? get userId => _userId;
  String? get state => _state;
  DateTime? get createdAt => _createdAt;

  WorkModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    _id = snapshot.data()!['id'] ?? '';
    _groupId = snapshot.data()!['groupId'] ?? '';
    _userId = snapshot.data()!['userId'] ?? '';
    startedAt = snapshot.data()!['startedAt'].toDate();
    startedLat = snapshot.data()!['startedLat'].toDouble();
    startedLon = snapshot.data()!['startedLon'].toDouble();
    endedAt = snapshot.data()!['endedAt'].toDate();
    endedLat = snapshot.data()!['endedLat'].toDouble();
    endedLon = snapshot.data()!['endedLon'].toDouble();
    breaks = _convertBreaks(snapshot.data()!['breaks']);
    _state = snapshot.data()!['state'] ?? '';
    _createdAt = snapshot.data()!['createdAt'].toDate();
  }

  List<BreaksModel> _convertBreaks(List breaks) {
    List<BreaksModel> converted = [];
    for (Map data in breaks) {
      converted.add(BreaksModel.fromMap(data));
    }
    return converted;
  }

  String startTime() {
    String _time = '${DateFormat('HH:mm').format(startedAt!)}';
    return _time;
  }

  String endTime() {
    String _time = '${DateFormat('HH:mm').format(endedAt!)}';
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
    String _time = '00:00';
    String _startedDate = '${DateFormat('yyyy-MM-dd').format(startedAt!)}';
    String _startedTime = '${startTime()}:00.000';
    DateTime _startedAt = DateTime.parse('$_startedDate $_startedTime');
    String _endedDate = '${DateFormat('yyyy-MM-dd').format(endedAt!)}';
    String _endedTime = '${endTime()}:00.000';
    DateTime _endedAt = DateTime.parse('$_endedDate $_endedTime');
    // 出勤時間と退勤時間の差を求める
    Duration _diff = _endedAt.difference(_startedAt);
    String _minutes = twoDigits(_diff.inMinutes.remainder(60));
    _time = '${twoDigits(_diff.inHours)}:$_minutes';
    // 休憩の合計時間を求める
    String _breakTime = '00:00';
    if (breaks.length > 0) {
      for (BreaksModel _break in breaks) {
        _breakTime = addTime(_breakTime, _break.breakTime());
      }
    }
    // 勤務時間と休憩の合計時間の差を求める
    _time = subTime(_time, _breakTime);
    return _time;
  }

  // 法定内時間/法定外時間
  List<String> legalTimes(GroupModel group) {
    String _time1 = '00:00';
    String _time2 = '00:00';
    List<String> _times = workTime().split(':');
    if (group.legal! <= int.parse(_times.first)) {
      _time1 = addTime(_time1, '0${group.legal}:00');
      String _tmp = subTime(workTime(), '0${group.legal}:00');
      _time2 = addTime(_time2, _tmp);
    } else {
      _time1 = addTime(_time1, workTime());
      _time2 = addTime(_time2, '00:00');
    }
    return [_time1, _time2];
  }

  // 深夜時間/深夜時間外
  List<String> nightTimes(GroupModel group) {
    String _time1 = '00:00';
    String _time2 = '00:00';
    String _startedDate = '${DateFormat('yyyy-MM-dd').format(startedAt!)}';
    String _startedTime = '${startTime()}:00.000';
    DateTime _startedAt = DateTime.parse('$_startedDate $_startedTime');
    String _endedDate = '${DateFormat('yyyy-MM-dd').format(endedAt!)}';
    String _endedTime = '${endTime()}:00.000';
    DateTime _endedAt = DateTime.parse('$_endedDate $_endedTime');
    // ----------------------------------------
    // 通常時間と深夜時間に分ける
    List<DateTime> _dayNightList = separateDayNight(
      startedAt: _startedAt,
      endedAt: _endedAt,
      nightStart: group.nightStart,
      nightEnd: group.nightEnd,
    );
    DateTime _dayS = _dayNightList[0];
    DateTime _dayE = _dayNightList[1];
    DateTime _nightS = _dayNightList[2];
    DateTime _nightE = _dayNightList[3];
    // ----------------------------------------
    // 深夜時間外
    if (_dayS.millisecondsSinceEpoch < _dayE.millisecondsSinceEpoch) {
      Duration _diff = _dayE.difference(_dayS);
      String _minutes = twoDigits(_diff.inMinutes.remainder(60));
      _time1 = '${twoDigits(_diff.inHours)}:$_minutes';
    }
    // 深夜時間
    if (_nightS.millisecondsSinceEpoch < _nightE.millisecondsSinceEpoch) {
      Duration _diff = _nightE.difference(_nightS);
      String _minutes = twoDigits(_diff.inMinutes.remainder(60));
      _time2 = '${twoDigits(_diff.inHours)}:$_minutes';
    }
    // ----------------------------------------
    return [_time1, _time2];
  }
}
