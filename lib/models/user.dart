import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String _id;
  String _workId;
  String _workBreakId;
  String _name;
  String _email;
  String _password;
  bool _admin;
  DateTime _createdAt;

  String get id => _id;
  String get workId => _workId;
  String get workBreakId => _workBreakId;
  String get name => _name;
  String get email => _email;
  String get password => _password;
  bool get admin => _admin;
  DateTime get createdAt => _createdAt;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()['id'];
    _workId = snapshot.data()['workId'];
    _workBreakId = snapshot.data()['workBreakId'];
    _name = snapshot.data()['name'];
    _email = snapshot.data()['email'];
    _password = snapshot.data()['password'];
    _admin = snapshot.data()['admin'];
    _createdAt = snapshot.data()['createdAt'].toDate();
  }
}
