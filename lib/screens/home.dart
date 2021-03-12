import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/screens/apply.dart';
import 'package:hatarakujikan_app/screens/history.dart';
import 'package:hatarakujikan_app/screens/work.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _tabs = [
    WorkScreen(),
    HistoryScreen(),
    ApplyScreen(),
  ];
  int _tabsIndex = 0;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    UserModel _user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(_user?.name ?? ''),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: _tabs[_tabsIndex],
      bottomNavigationBar: Container(
        decoration: kNavigationDecoration,
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _tabsIndex = index;
            });
          },
          backgroundColor: Colors.white,
          currentIndex: _tabsIndex,
          fixedColor: Colors.blueAccent,
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
            BottomNavigationBarItem(
              icon: Icon(Icons.question_answer),
              label: '申請/承認',
            ),
          ],
        ),
      ),
    );
  }
}
