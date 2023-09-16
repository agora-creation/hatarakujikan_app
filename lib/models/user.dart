import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String _id = '';
  String _number = '';
  String _name = '';
  String _email = '';
  String _password = '';
  String _recordPassword = '';
  int _workLv = 0;
  String _lastWorkId = '';
  String _lastBreakId = '';
  bool _autoWorkEnd = false;
  String _autoWorkEndTime = '00:00';
  String _token = '';
  bool _smartphone = false;
  DateTime _createdAt = DateTime.now();

  String get id => _id;
  String get number => _number;
  String get name => _name;
  String get email => _email;
  String get password => _password;
  String get recordPassword => _recordPassword;
  int get workLv => _workLv;
  String get lastWorkId => _lastWorkId;
  String get lastBreakId => _lastBreakId;
  bool get autoWorkEnd => _autoWorkEnd;
  String get autoWorkEndTime => _autoWorkEndTime;
  String get token => _token;
  bool get smartphone => _smartphone;
  DateTime get createdAt => _createdAt;

  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> map = snapshot.data() ?? {};
    _id = map['id'] ?? '';
    _number = map['number'] ?? '';
    _name = map['name'] ?? '';
    _email = map['email'] ?? '';
    _password = map['password'] ?? '';
    _recordPassword = map['recordPassword'] ?? '';
    _workLv = map['workLv'] ?? 0;
    _lastWorkId = map['lastWorkId'] ?? '';
    _lastBreakId = map['lastBreakId'] ?? '';
    _autoWorkEnd = map['autoWorkEnd'] ?? false;
    _autoWorkEndTime = map['autoWorkEndTime'] ?? '00:00';
    _token = map['token'] ?? '';
    _smartphone = map['smartphone'] ?? false;
    if (map['createdAt'] != null) {
      _createdAt = map['createdAt'].toDate() ?? DateTime.now();
    }
  }
}
