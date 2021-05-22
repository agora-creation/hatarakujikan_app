import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF4DD0E1),
                  Color(0xFF00BCD4),
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('はたらくじかん', style: kTitleTextStyle),
                      Text('for スマートフォン', style: kSubTitleTextStyle),
                    ],
                  ),
                  SizedBox(height: 32.0),
                  Loading(color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
