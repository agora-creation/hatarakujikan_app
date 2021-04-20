class BreaksModel {
  String _id;
  DateTime _startedAt;
  double _startedLat;
  double _startedLon;
  DateTime _endedAt;
  double _endedLat;
  double _endedLon;

  String get id => _id;
  DateTime get startedAt => _startedAt;
  double get startedLat => _startedLat;
  double get startedLon => _startedLon;
  DateTime get endedAt => _endedAt;
  double get endedLat => _endedLat;
  double get endedLon => _endedLon;

  BreaksModel.fromMap(Map data) {
    _id = data['id'];
    _startedAt = data['startedAt'].toDate();
    _startedLat = data['startedLat'];
    _startedLon = data['startedLon'];
    _endedAt = data['endedAt'].toDate();
    _endedLat = data['endedLat'];
    _endedLon = data['endedLon'];
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
}
