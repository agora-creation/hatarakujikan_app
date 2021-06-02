import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/providers/group.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/work.dart';
import 'package:hatarakujikan_app/screens/apply.dart';
import 'package:hatarakujikan_app/screens/group.dart';
import 'package:hatarakujikan_app/screens/history.dart';
import 'package:hatarakujikan_app/screens/notice.dart';
import 'package:hatarakujikan_app/screens/setting.dart';
import 'package:hatarakujikan_app/screens/work.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabsIndex = 0;

  @override
  Widget build(BuildContext context) {
    final groupProvider = Provider.of<GroupProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final workProvider = Provider.of<WorkProvider>(context);
    final List<Widget> _tabs = [
      WorkScreen(
        userProvider: userProvider,
        workProvider: workProvider,
      ),
      HistoryScreen(
        userProvider: userProvider,
        workProvider: workProvider,
      ),
      ApplyScreen(userProvider: userProvider),
      GroupScreen(
        groupProvider: groupProvider,
        userProvider: userProvider,
      ),
    ];
    Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
        .collection('user')
        .doc(userProvider.user?.id)
        .collection('notice')
        .where('read', isEqualTo: false)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('${userProvider.user?.name}'),
        actions: [
          StreamBuilder<QuerySnapshot>(
            stream: _stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return IconButton(
                  onPressed: null,
                  icon: Icon(Icons.notifications_off_outlined),
                );
              }
              List<DocumentSnapshot> docs = snapshot.data.docs;
              if (docs.length == 0) {
                return IconButton(
                  onPressed: () => overlayScreen(context, NoticeScreen()),
                  icon: Icon(Icons.notifications_none),
                );
              } else {
                return IconButton(
                  onPressed: () => overlayScreen(context, NoticeScreen()),
                  icon: Icon(
                    Icons.notification_important_sharp,
                    color: Colors.red,
                  ),
                );
              }
            },
          ),
          IconButton(
            onPressed: () => overlayScreen(context, SettingScreen()),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: _tabs[_tabsIndex],
      bottomNavigationBar: Container(
        decoration: kNavigationDecoration,
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() => _tabsIndex = index);
          },
          backgroundColor: Colors.white,
          currentIndex: _tabsIndex,
          fixedColor: Colors.cyan.shade700,
          type: BottomNavigationBarType.fixed,
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
      ),
    );
  }
}
