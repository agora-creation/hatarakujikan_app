import 'package:cloud_firestore/cloud_firestore.dart';

class ApplyWorkService {
  String _collection = 'applyWork';
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String id() {
    return _firebaseFirestore.collection(_collection).doc().id;
  }

  void create(Map<String, dynamic> values) {
    _firebaseFirestore.collection(_collection).doc(values['id']).set(values);
  }

  void delete(Map<String, dynamic> values) {
    _firebaseFirestore.collection(_collection).doc(values['id']).delete();
  }
}
