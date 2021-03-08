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
      floatingActionButton: _tabsIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text('打刻する'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('11:00'),
                          TextButton(
                            onPressed: () {},
                            child: Text('出勤する'),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('退勤する'),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('休憩する'),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('休憩しない'),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('やめる'),
                        ),
                      ],
                    );
                  },
                );
              },
              label: Text('打刻する'),
              icon: Icon(Icons.add),
              backgroundColor: Colors.blueAccent.withOpacity(0.8),
            )
          : FloatingActionButton.extended(
              onPressed: () {},
              label: Text('申請する'),
              icon: Icon(Icons.add),
              backgroundColor: Colors.redAccent.withOpacity(0.8),
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
