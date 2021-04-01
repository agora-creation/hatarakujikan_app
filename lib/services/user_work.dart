import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_app/models/user_work.dart';
import 'package:intl/intl.dart';

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

  Future<List<UserWorkModel>> selectList(
      {String userId, DateTime startAt, DateTime endAt}) async {
    List<UserWorkModel> _works = [];
    Timestamp _startAt = Timestamp.fromMillisecondsSinceEpoch(DateTime.parse(
            '${DateFormat('yyyy-MM-dd').format(startAt)} 00:00:00.000')
        .millisecondsSinceEpoch);
    Timestamp _endAt = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.parse('${DateFormat('yyyy-MM-dd').format(endAt)} 23:59:59.999')
            .millisecondsSinceEpoch);
    QuerySnapshot snapshot = await _firebaseFirestore
        .collection(_collection)
        .doc(userId)
        .collection(_subCollection)
        .where('userId', isEqualTo: userId)
        .orderBy('startedAt', descending: false)
        .startAt([_startAt]).endAt([_endAt]).get();
    for (DocumentSnapshot _work in snapshot.docs) {
      _works.add(UserWorkModel.fromSnapshot(_work));
    }
    return _works;
  }
}
