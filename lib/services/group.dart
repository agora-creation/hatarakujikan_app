import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_app/models/group.dart';

class GroupService {
  String _collection = 'group';
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<GroupModel> select({String groupId}) async {
    GroupModel _group;
    await _firebaseFirestore
        .collection(_collection)
        .doc(groupId)
        .get()
        .then((value) {
      _group = GroupModel.fromSnapshot(value);
    }).catchError((e) {
      _group = null;
    });
    return _group;
  }

  Future<List<GroupModel>> selectList({List<String> groups}) async {
    List<GroupModel> _groups = [];
    List<String> _whereIn = [];
    for (String _groupId in groups) {
      _whereIn.add(_groupId);
    }
    if (_whereIn.length > 0) {
      QuerySnapshot snapshot = await _firebaseFirestore
          .collection(_collection)
          .where('id', whereIn: _whereIn)
          .orderBy('createdAt', descending: true)
          .get();
      for (DocumentSnapshot _group in snapshot.docs) {
        _groups.add(GroupModel.fromSnapshot(_group));
      }
    }
    return _groups;
  }
}
