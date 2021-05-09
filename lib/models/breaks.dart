class BreaksModel {
  String _id;
  DateTime _startedAt;
  double _startedLat;
  double _startedLon;
  DateTime endedAt;
  double endedLat;
  double endedLon;

  String get id => _id;
  DateTime get startedAt => _startedAt;
  double get startedLat => _startedLat;
  double get startedLon => _startedLon;

  BreaksModel.fromMap(Map data) {
    _id = data['id'];
    _startedAt = data['startedAt'].toDate();
    _startedLat = data['startedLat'];
    _startedLon = data['startedLon'];
    endedAt = data['endedAt'].toDate();
    endedLat = data['endedLat'];
    endedLon = data['endedLon'];
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

  String diff() {
    Duration _diff = endedAt.difference(_startedAt);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(_diff.inMinutes.remainder(60));
    return '${twoDigits(_diff.inHours)}:$twoDigitMinutes';
  }
}
