import 'package:hatarakujikan_app/helpers/functions.dart';

class BreaksModel {
  String _id = '';
  DateTime startedAt = DateTime.now();
  double startedLat = 0;
  double startedLon = 0;
  DateTime endedAt = DateTime.now();
  double endedLat = 0;
  double endedLon = 0;

  String get id => _id;

  BreaksModel.fromMap(Map data) {
    _id = data['id'] ?? '';
    startedAt = data['startedAt'].toDate() ?? DateTime.now();
    startedLat = data['startedLat'].toDouble() ?? 0;
    startedLon = data['startedLon'].toDouble() ?? 0;
    endedAt = data['endedAt'].toDate() ?? DateTime.now();
    endedLat = data['endedLat'].toDouble() ?? 0;
    endedLon = data['endedLon'].toDouble() ?? 0;
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
    String _time = dateText('HH:mm', startedAt);
    return _time;
  }

  String endTime() {
    String _time = dateText('HH:mm', endedAt);
    return _time;
  }

  String breakTime() {
    String _time = '00:00';
    String _startedDate = dateText('yyyy-MM-dd', startedAt);
    String _startedTime = '${startTime()}:00.000';
    DateTime _startedAt = DateTime.parse('$_startedDate $_startedTime');
    String _endedDate = dateText('yyyy-MM-dd', endedAt);
    String _endedTime = '${endTime()}:00.000';
    DateTime _endedAt = DateTime.parse('$_endedDate $_endedTime');
    // 休憩開始時間と休憩終了時間の差を求める
    Duration _diff = _endedAt.difference(_startedAt);
    String _minutes = twoDigits(_diff.inMinutes.remainder(60));
    _time = '${twoDigits(_diff.inHours)}:$_minutes';
    return _time;
  }
}
