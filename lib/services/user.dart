import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_app/models/user.dart';

class UserService {
  String _collection = 'user';
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void create(Map<String, dynamic> values) {
    _firebaseFirestore.collection(_collection).doc(values['id']).set(values);
  }

  void update(Map<String, dynamic> values) {
    _firebaseFirestore.collection(_collection).doc(values['id']).update(values);
  }

  Future<UserModel> select({String userId}) async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection(_collection).doc(userId).get();
    return UserModel.fromSnapshot(snapshot);
  }

  Future<List<UserModel>> selectList({String groupId}) async {
    List<UserModel> _users = [];
    await _firebaseFirestore
        .collection(_collection)
        .where('groups', arrayContains: groupId)
        .orderBy('recordPassword', descending: false)
        .get()
        .then((value) {
      for (DocumentSnapshot _user in value.docs) {
        _users.add(UserModel.fromSnapshot(_user));
      }
    });
    return _users;
  }
}
