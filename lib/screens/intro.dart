import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/navigation.dart';
import 'package:hatarakujikan_app/screens/registration.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<PageViewModel> _getPages() {
    return [
      PageViewModel(
        image: Image.asset('assets/images/img1.jpg', width: 300.0, height: 300),
        title: 'ようこそ！はたらくじかんへ',
        bodyWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('このアプリでは、あなたの働いた時間を記録・確認することができます。'),
          ],
        ),
      ),
      PageViewModel(
        image: Image.asset('assets/images/img2.jpg', width: 300.0, height: 300),
        title: '勤務時間の記録',
        bodyWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('出勤するとき、または退勤するときにこのアプリで時間を記録をすることができます。'),
            Text('GPSによる記録を利用することで、出勤場所や退勤場所を確認することができます。'),
          ],
        ),
      ),
      PageViewModel(
        image: Image.asset('assets/images/img3.jpg', width: 300.0, height: 300),
        title: '会社/組織管理',
        bodyWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('会社/組織で利用する場合、会社/組織登録をすることで、様々な機能を使用することができます。'),
            Text('・記録の共有と修正'),
            Text('・各種申請'),
            Text('・タブレット端末(アプリ)での利用'),
            Text('・WEB管理画面による管理'),
          ],
        ),
      ),
      PageViewModel(
        image: Image.asset('assets/images/img1.jpg', width: 300.0, height: 300),
        title: '個人登録をする',
        bodyWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('アプリの個人利用は無料です。'),
          ],
        ),
        footer: RoundBackgroundButton(
          labelText: 'はじめる',
          labelColor: Colors.white,
          backgroundColor: Colors.blue,
          labelFontSize: 16.0,
          padding: EdgeInsets.symmetric(vertical: 16.0),
          onPressed: () => _complete(context),
        ),
      ),
    ];
  }

  void _complete(context) {
    changeScreen(context, RegistrationScreen());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        showSkipButton: true,
        skip: Text('スキップ'),
        onSkip: () => _complete(context),
        showNextButton: true,
        next: Text('次へ'),
        showDoneButton: false,
        pages: _getPages(),
      ),
    );
  }
}
