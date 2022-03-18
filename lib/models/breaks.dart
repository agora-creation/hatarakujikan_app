import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:intl/intl.dart';

class BreaksModel {
  String? _id;
  DateTime? startedAt;
  double? startedLat;
  double? startedLon;
  DateTime? endedAt;
  double? endedLat;
  double? endedLon;

  String? get id => _id;

  BreaksModel.fromMap(Map data) {
    _id = data['id'];
    startedAt = data['startedAt'].toDate();
    startedLat = data['startedLat'].toDouble();
    startedLon = data['startedLon'].toDouble();
    endedAt = data['endedAt'].toDate();
    endedLat = data['endedLat'].toDouble();
    endedLon = data['endedLon'].toDouble();
  }

  Map toMap() => {
        'id': id,
        'startedAt': startedAt,
        'startedLat': startedLat,
        'startedLon': startedLon,
        'endedAt': endedAt,
        'endedLat': endedLat,
        'endedLon': endedLon,
      };

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
    String _startedDate = '${DateFormat('yyyy-MM-dd').format(startedAt!)}';
    String _startedTime = '${startTime()}:00.000';
    DateTime _startedAt = DateTime.parse('$_startedDate $_startedTime');
    String _endedDate = '${DateFormat('yyyy-MM-dd').format(endedAt!)}';
    String _endedTime = '${endTime()}:00.000';
    DateTime _endedAt = DateTime.parse('$_endedDate $_endedTime');
    // 休憩開始時間と休憩終了時間の差を求める
    Duration _diff = _endedAt.difference(_startedAt);
    String _minutes = twoDigits(_diff.inMinutes.remainder(60));
    _time = '${twoDigits(_diff.inHours)}:$_minutes';
    return _time;
  }
}
