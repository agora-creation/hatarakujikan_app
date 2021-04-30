import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_app/models/user_notice.dart';

class UserNoticeService {
  String _collection = 'user';
  String _subCollection = 'notice';
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void update(Map<String, dynamic> values) {
    _firebaseFirestore
        .collection(_collection)
        .doc(values['userId'])
        .collection(_subCollection)
        .doc(values['id'])
        .update(values);
  }

  Future<List<UserNoticeModel>> selectList({String userId}) async {
    List<UserNoticeModel> _notices = [];
    QuerySnapshot snapshot = await _firebaseFirestore
        .collection(_collection)
        .doc(userId)
        .collection(_subCollection)
        .orderBy('createdAt', descending: true)
        .get();
    for (DocumentSnapshot _notice in snapshot.docs) {
      _notices.add(UserNoticeModel.fromSnapshot(_notice));
    }
    return _notices;
  }
}
