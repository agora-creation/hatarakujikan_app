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

  Future<UserModel> select({String id}) async {
    UserModel _user;
    await _firebaseFirestore
        .collection(_collection)
        .doc(id)
        .get()
        .then((value) {
      _user = UserModel.fromSnapshot(value);
    });
    return _user;
  }
}
