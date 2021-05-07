import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/models/groups.dart';

class GroupService {
  String _collection = 'group';
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

  Future<List<GroupModel>> selectList({List<GroupsModel> groups}) async {
    List<GroupModel> _groups = [];
    List<String> _whereIn = [];
    for (GroupsModel groupsModel in groups) {
      _whereIn.add(groupsModel.groupId);
    }
    QuerySnapshot snapshot = await _firebaseFirestore
        .collection(_collection)
        .where('id', whereIn: _whereIn)
        .orderBy('createdAt', descending: true)
        .get();
    for (DocumentSnapshot _group in snapshot.docs) {
      _groups.add(GroupModel.fromSnapshot(_group));
    }
    for (GroupModel groupModel in _groups) {
      for (GroupsModel groupsModel in groups) {
        if (groupModel.id == groupsModel.groupId && groupsModel.fixed == true) {
          groupModel.fixed = true;
        }
      }
    }
    return _groups;
  }
}
