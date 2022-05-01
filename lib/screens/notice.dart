import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/models/user_notice.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/user_notice.dart';
import 'package:hatarakujikan_app/screens/notice_details.dart';
import 'package:hatarakujikan_app/widgets/notice_list.dart';

class NoticeScreen extends StatelessWidget {
  final UserProvider userProvider;
  final UserNoticeProvider userNoticeProvider;

  NoticeScreen({
    required this.userProvider,
    required this.userNoticeProvider,
  });

  @override
  Widget build(BuildContext context) {
    UserModel? user = userProvider.user;
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
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: userNoticeProvider.streamList(userId: user?.id),
        builder: (context, snapshot) {
          notices.clear();
          if (snapshot.hasData) {
            for (DocumentSnapshot<Map<String, dynamic>> doc
                in snapshot.data!.docs) {
              notices.add(UserNoticeModel.fromSnapshot(doc));
            }
          }
          if (notices.length == 0) return Center(child: Text('お知らせはありません'));
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            itemCount: notices.length,
            itemBuilder: (_, index) {
              UserNoticeModel _notice = notices[index];
              return NoticeList(
                notice: _notice,
                onTap: () => nextScreen(
                  context,
                  NoticeDetailsScreen(
                    userNoticeProvider: userNoticeProvider,
                    notice: _notice,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
