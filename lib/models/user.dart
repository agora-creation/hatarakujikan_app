import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_app/models/groups.dart';

class UserModel {
  String _id;
  String _name;
  String _email;
  String _password;
  int _workLv;
  String _lastWorkId;
  String _lastBreakId;
  List<GroupsModel> groups;
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
    groups = _convertGroups(snapshot.data()['groups']) ?? [];
    _createdAt = snapshot.data()['createdAt'].toDate();
  }

  List<GroupsModel> _convertGroups(List groups) {
    List<GroupsModel> converted = [];
    for (Map data in groups) {
      converted.add(GroupsModel.fromMap(data));
    }
    return converted;
  }
}
