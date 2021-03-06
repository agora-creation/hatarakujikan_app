import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/screens/login.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        leading: Container(),
        title: Text('ユーザー'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
                fullscreenDialog: true,
              ),
            );
          },
          child: Text('ログアウト'),
        ),
      ),
    );
  }
}
