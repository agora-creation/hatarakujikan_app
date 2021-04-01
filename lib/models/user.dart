import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String _id;
  String _workId;
  String _breaksId;
  String _name;
  String _email;
  String _password;
  bool _admin;
  DateTime _createdAt;

  String get id => _id;
  String get workId => _workId;
  String get breaksId => _breaksId;
  String get name => _name;
  String get email => _email;
  String get password => _password;
  bool get admin => _admin;
  DateTime get createdAt => _createdAt;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()['id'];
    _workId = snapshot.data()['workId'];
    _breaksId = snapshot.data()['breaksId'];
    _name = snapshot.data()['name'];
    _email = snapshot.data()['email'];
    _password = snapshot.data()['password'];
    _admin = snapshot.data()['admin'];
    _createdAt = snapshot.data()['createdAt'].toDate();
  }
}
