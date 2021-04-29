import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String _id;
  String _name;
  String _email;
  String _password;
  int _workLv;
  String _lastWorkId;
  String _lastBreakId;
  List<String> groups;
  DateTime _createdAt;

  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get password => _password;
  int get workLv => _workLv;
  String get lastWorkId => _lastWorkId;
  String get lastBreakId => _lastBreakId;
  DateTime get createdAt => _createdAt;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()['id'];
    _name = snapshot.data()['name'];
    _email = snapshot.data()['email'];
    _password = snapshot.data()['password'];
    _workLv = snapshot.data()['workLv'] ?? 0;
    _lastWorkId = snapshot.data()['lastWorkId'] ?? '';
    _lastBreakId = snapshot.data()['lastBreakId'] ?? '';
    groups = _convertGroups(snapshot.data()['group']) ?? [];
    _createdAt = snapshot.data()['createdAt'].toDate();
  }

  List<String> _convertGroups(List groups) {
    List<String> converted = [];
    for (String group in groups) {
      converted.add(group);
    }
    return converted;
  }
}
