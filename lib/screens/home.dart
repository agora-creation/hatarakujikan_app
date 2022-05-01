import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/providers/apply_pto.dart';
import 'package:hatarakujikan_app/providers/apply_work.dart';
import 'package:hatarakujikan_app/providers/group.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/user_notice.dart';
import 'package:hatarakujikan_app/providers/work.dart';
import 'package:hatarakujikan_app/screens/apply.dart';
import 'package:hatarakujikan_app/screens/group.dart';
import 'package:hatarakujikan_app/screens/history.dart';
import 'package:hatarakujikan_app/screens/notice.dart';
import 'package:hatarakujikan_app/screens/setting.dart';
import 'package:hatarakujikan_app/screens/work.dart';
import 'package:hatarakujikan_app/widgets/custom_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final applyPTOProvider = Provider.of<ApplyPTOProvider>(context);
    final applyWorkProvider = Provider.of<ApplyWorkProvider>(context);
    final groupProvider = Provider.of<GroupProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final userNoticeProvider = Provider.of<UserNoticeProvider>(context);
    final workProvider = Provider.of<WorkProvider>(context);
    UserModel? user = userProvider.user;
    List<Widget> _tabs = [
      WorkScreen(
        userProvider: userProvider,
        workProvider: workProvider,
      ),
      HistoryScreen(
        userProvider: userProvider,
        workProvider: workProvider,
      ),
      ApplyScreen(
        applyPTOProvider: applyPTOProvider,
        applyWorkProvider: applyWorkProvider,
        userProvider: userProvider,
      ),
      GroupScreen(
        groupProvider: groupProvider,
        userProvider: userProvider,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(user?.name ?? ''),
        actions: [
          StreamBuilder<QuerySnapshot>(
            stream: userProvider.streamNotice(userId: user?.id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return IconButton(
                  icon: Icon(Icons.notifications_off_outlined),
                  onPressed: null,
                );
              }
              List<DocumentSnapshot> docs = snapshot.data!.docs;
              return IconButton(
                icon: docs.length == 0
                    ? Icon(Icons.notifications_none)
                    : Icon(
                        Icons.notification_important_sharp,
                        color: Colors.red,
                      ),
                onPressed: () => overlayScreen(
                  context,
                  NoticeScreen(
                    userProvider: userProvider,
                    userNoticeProvider: userNoticeProvider,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => overlayScreen(
              context,
              SettingScreen(
                userProvider: userProvider,
                userNoticeProvider: userNoticeProvider,
              ),
            ),
          ),
        ],
      ),
      body: _tabs[userProvider.tabsIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        onTap: (index) => userProvider.changeTabs(index),
        currentIndex: userProvider.tabsIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '勤務履歴',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: '各種申請',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: '会社/組織',
          ),
        ],
      ),
    );
  }
}
