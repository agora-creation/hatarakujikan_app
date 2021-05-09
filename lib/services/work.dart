import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_app/models/work.dart';

class WorkService {
  String _collection = 'work';
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String id() {
    String _id = _firebaseFirestore.collection(_collection).doc().id;
    return _id;
  }

  void create(Map<String, dynamic> values) {
    _firebaseFirestore.collection(_collection).doc(values['id']).set(values);
  }

  void update(Map<String, dynamic> values) {
    _firebaseFirestore.collection(_collection).doc(values['id']).update(values);
  }

  void delete(Map<String, dynamic> values) {
    _firebaseFirestore.collection(_collection).doc(values['id']).delete();
  }

  Future<WorkModel> select({String workId}) async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection(_collection).doc(workId).get();
    return WorkModel.fromSnapshot(snapshot);
  }
}
