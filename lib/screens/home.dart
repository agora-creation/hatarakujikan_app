import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/navigation.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/providers/user_work.dart';
import 'package:hatarakujikan_app/screens/history.dart';
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
    final userProvider = Provider.of<UserProvider>(context);
    UserModel _user = userProvider.user;
    final userWorkProvider = Provider.of<UserWorkProvider>(context);
    final List<Widget> _tabs = [
      WorkScreen(
        user: _user,
        userProvider: userProvider,
        userWorkProvider: userWorkProvider,
      ),
      HistoryScreen(
        user: _user,
        userWorkProvider: userWorkProvider,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(_user?.name ?? ''),
        actions: [
          // IconButton(
          //   onPressed: () => overlayScreen(context, NoticeScreen()),
          //   icon: Icon(Icons.notifications),
          // ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.group),
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
              label: '打刻履歴',
            ),
          ],
        ),
      ),
    );
  }
}
