import 'package:cloud_firestore/cloud_firestore.dart';

class UserWorkBreakService {
  String _collection = 'user';
  String _subCollection = 'work';
  String _subSubCollection = 'break';
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String newId({String userId, String workId}) {
    String _id = _firebaseFirestore
        .collection(_collection)
        .doc(userId)
        .collection(_subCollection)
        .doc(workId)
        .collection(_subSubCollection)
        .doc()
        .id;
    return _id;
  }

  void create(Map<String, dynamic> values) {
    _firebaseFirestore
        .collection(_collection)
        .doc(values['userId'])
        .collection(_subCollection)
        .doc(values['workId'])
        .collection(_subSubCollection)
        .doc(values['id'])
        .set(values);
  }

  void update(Map<String, dynamic> values) {
    _firebaseFirestore
        .collection(_collection)
        .doc(values['userId'])
        .collection(_subCollection)
        .doc(values['workId'])
        .collection(_subSubCollection)
        .doc(values['id'])
        .update(values);
  }

  void delete(Map<String, dynamic> values) {
    _firebaseFirestore
        .collection(_collection)
        .doc(values['userId'])
        .collection(_subCollection)
        .doc(values['workId'])
        .collection(_subSubCollection)
        .doc(values['id'])
        .delete();
  }
}
