import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

Stream<QuerySnapshot> userWorkStream(
    {String userId, DateTime startAt, DateTime endAt}) {
  Timestamp _startAt = Timestamp.fromMillisecondsSinceEpoch(
      DateTime.parse('${DateFormat('yyyy-MM-dd').format(startAt)} 00:00:00.000')
          .millisecondsSinceEpoch);
  Timestamp _endAt = Timestamp.fromMillisecondsSinceEpoch(
      DateTime.parse('${DateFormat('yyyy-MM-dd').format(endAt)} 23:59:59.999')
          .millisecondsSinceEpoch);
  Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection('user')
      .doc(userId)
      .collection('work')
      .where('userId', isEqualTo: userId)
      .orderBy('startedAt', descending: false)
      .startAt([_startAt]).endAt([_endAt]).snapshots();
  return _stream;
}
