import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_app/models/work_break.dart';

class WorkBreakService {
  String _collection = 'work';
  String _subCollection = 'break';
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String id({String workId}) {
    String _id = _firebaseFirestore
        .collection(_collection)
        .doc(workId)
        .collection(_subCollection)
        .doc()
        .id;
    return _id;
  }

  void create(Map<String, dynamic> values) {
    _firebaseFirestore
        .collection(_collection)
        .doc(values['workId'])
        .collection(_subCollection)
        .doc(values['id'])
        .set(values);
  }

  void update(Map<String, dynamic> values) {
    _firebaseFirestore
        .collection(_collection)
        .doc(values['workId'])
        .collection(_subCollection)
        .doc(values['id'])
        .update(values);
  }

  void delete(Map<String, dynamic> values) {
    _firebaseFirestore
        .collection(_collection)
        .doc(values['workId'])
        .collection(_subCollection)
        .doc(values['id'])
        .delete();
  }

  Future<List<WorkBreakModel>> selectList({String workId}) async {
    List<WorkBreakModel> _breaks = [];
    QuerySnapshot snapshot = await _firebaseFirestore
        .collection(_collection)
        .doc(workId)
        .collection(_subCollection)
        .orderBy('startedAt', descending: false)
        .get();
    for (DocumentSnapshot _break in snapshot.docs) {
      _breaks.add(WorkBreakModel.fromSnapshot(_break));
    }
    return _breaks;
  }
}
