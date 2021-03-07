import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/screens/app.dart';
import 'package:hatarakujikan_app/screens/user.dart';
import 'package:hatarakujikan_app/screens/work.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _tabs = [
    WorkScreen(),
    AppScreen(),
  ];
  int _tabsIndex = 0;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    UserModel _user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(10.0),
          child: CircleAvatar(backgroundColor: Colors.grey),
        ),
        title: GestureDetector(
          onTap: () {
            showMaterialModalBottomSheet(
              context: context,
              builder: (context) => UserScreen(),
            );
          },
          child: Text(_user?.name ?? ''),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showMaterialModalBottomSheet(
                context: context,
                builder: (context) => UserScreen(),
              );
            },
            icon: Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {
              showMaterialModalBottomSheet(
                context: context,
                builder: (context) => UserScreen(),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: _tabs[_tabsIndex],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(_tabsIndex == 0 ? '打刻する' : '申請する'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.blueAccent.withOpacity(0.8),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _tabsIndex = index;
            });
          },
          currentIndex: _tabsIndex,
          fixedColor: Colors.blueAccent,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time),
              label: '打刻',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: '申請',
            ),
          ],
        ),
      ),
    );
  }
}
