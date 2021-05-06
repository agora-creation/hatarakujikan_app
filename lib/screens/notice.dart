import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/navigation.dart';
import 'package:hatarakujikan_app/models/user_notice.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/user_notice.dart';
import 'package:hatarakujikan_app/screens/notice_details.dart';
import 'package:hatarakujikan_app/widgets/custom_notice_list_tile.dart';
import 'package:provider/provider.dart';

class NoticeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userNoticeProvider = Provider.of<UserNoticeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey,
        elevation: 0.0,
        centerTitle: true,
        title: Text('お知らせ', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
      body: FutureBuilder<List<UserNoticeModel>>(
        future: userNoticeProvider.selectList(userId: userProvider.user?.id),
        builder: (context, snapshot) {
          List<UserNoticeModel> notices = [];
          if (snapshot.connectionState == ConnectionState.done) {
            notices.clear();
            notices = snapshot.data;
          } else {
            notices.clear();
          }
          if (notices.length > 0) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              itemCount: notices.length,
              itemBuilder: (_, index) {
                UserNoticeModel _notice = notices[index];
                return CustomNoticeListTile(
                  notice: _notice,
                  onTap: () => nextScreen(
                    context,
                    NoticeDetailsScreen(
                      notice: _notice,
                      userNoticeProvider: userNoticeProvider,
                    ),
                  ),
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
