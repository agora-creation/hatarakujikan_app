import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_app/models/user_work.dart';

class UserWorkService {
  String _collection = 'user';
  String _subCollection = 'work';
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String newId({String userId}) {
    String _id = _firebaseFirestore
        .collection(_collection)
        .doc(userId)
        .collection(_subCollection)
        .doc()
        .id;
    return _id;
  }

  void create(Map<String, dynamic> values) {
    _firebaseFirestore
        .collection(_collection)
        .doc(values['userId'])
        .collection(_subCollection)
        .doc(values['id'])
        .set(values);
  }

  void update(Map<String, dynamic> values) {
    _firebaseFirestore
        .collection(_collection)
        .doc(values['userId'])
        .collection(_subCollection)
        .doc(values['id'])
        .update(values);
  }

  void delete(Map<String, dynamic> values) {
    _firebaseFirestore
        .collection(_collection)
        .doc(values['userId'])
        .collection(_subCollection)
        .doc(values['id'])
        .delete();
  }

  Future<List<UserWorkModel>> selectList({String userId}) async {
    List<UserWorkModel> _works = [];
    QuerySnapshot snapshot = await _firebaseFirestore
        .collection(_collection)
        .doc(userId)
        .collection(_subCollection)
        .orderBy('startedAt', descending: false)
        .get();
    for (DocumentSnapshot _work in snapshot.docs) {
      _works.add(UserWorkModel.fromSnapshot(_work));
    }
    return _works;
  }
}
