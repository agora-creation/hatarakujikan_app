import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/models/user_notice.dart';
import 'package:hatarakujikan_app/providers/user_notice.dart';
import 'package:hatarakujikan_app/screens/notice_details.dart';
import 'package:hatarakujikan_app/widgets/custom_notice_list_tile.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';
import 'package:provider/provider.dart';

class NoticeScreen extends StatelessWidget {
  final UserModel user;

  NoticeScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    final userNoticeProvider = Provider.of<UserNoticeProvider>(context);
    Stream<QuerySnapshot<Map<String, dynamic>>> _stream = FirebaseFirestore
        .instance
        .collection('user')
        .doc(user.id)
        .collection('notice')
        .orderBy('createdAt', descending: true)
        .snapshots();
    List<UserNoticeModel> notices = [];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('お知らせ'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading(color: Colors.cyan);
          }
          notices.clear();
          for (DocumentSnapshot<Map<String, dynamic>> doc
              in snapshot.data!.docs) {
            notices.add(UserNoticeModel.fromSnapshot(doc));
          }
          if (notices.length > 0) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              itemCount: notices.length,
              itemBuilder: (_, index) {
                UserNoticeModel _notice = notices[index];
                return CustomNoticeListTile(
                  onTap: () => nextScreen(
                    context,
                    NoticeDetailsScreen(
                      userNoticeProvider: userNoticeProvider,
                      notice: _notice,
                    ),
                  ),
                  notice: _notice,
                );
              },
            );
          } else {
            return Center(child: Text('お知らせはありません'));
          }
        },
      ),
    );
  }
}
