class BreaksModel {
  String _id;
  DateTime _startedAt;
  double _startedLon;
  double _startedLat;
  DateTime _endedAt;
  double _endedLon;
  double _endedLat;

  String get id => _id;
  DateTime get startedAt => _startedAt;
  double get startedLon => _startedLon;
  double get startedLat => _startedLat;
  DateTime get endedAt => _endedAt;
  double get endedLon => _endedLon;
  double get endedLat => _endedLat;

  BreaksModel.fromMap(Map data) {
    _id = data['id'];
    _startedAt = data['startedAt'].toDate();
    _startedLon = data['startedLon'];
    _startedLat = data['startedLat'];
    _endedAt = data['endedAt'].toDate();
    _endedLon = data['endedLon'];
    _endedLat = data['endedLat'];
  }

  Map toMap() => {
        'id': id,
        'startedAt': startedAt,
        'startedLon': startedLon,
        'startedLat': startedLat,
        'endedAt': endedAt,
        'endedLon': endedLon,
        'endedLat': endedLat,
      };
}
