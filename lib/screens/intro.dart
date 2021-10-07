import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/dialogs.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
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
        image: Image.asset(
          'assets/images/step1.png',
          width: 200.0,
          height: 200.0,
        ),
        title: 'はじめに',
        bodyWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('このアプリでは、勤務に関する様々なことがあなたのスマートフォンでできるようになります。'),
            Text('・出退勤の記録と確認'),
            Text('・各種申請'),
            Text('・勤務に関する通知　など'),
          ],
        ),
      ),
      PageViewModel(
        image: Image.asset(
          'assets/images/step2.png',
          width: 200.0,
          height: 200.0,
        ),
        title: '出退勤時のセキュリティ',
        bodyWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('出退勤時の記録は、場所を問わずどこでもできます。'),
            Text('あなたのスマートフォンのGPS機能を使うことによって、出退勤時の場所も記録することができます。'),
            Text('また、出退勤の可能な場所(範囲)も制限することができます。'),
          ],
        ),
      ),
      PageViewModel(
        image: Image.asset(
          'assets/images/step3.png',
          width: 200.0,
          height: 200.0,
        ),
        title: '「会社/組織」へ所属',
        bodyWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('あなたのアカウントを「会社/組織」に所属させることで、記録の共有などができるようになります。'),
            Text('また、管理者になることで、他のサービスも利用が可能になります。'),
            Text('・タブレット端末(別アプリ)での利用'),
            Text('・WEB管理画面による「会社/組織」管理　など'),
          ],
        ),
      ),
      PageViewModel(
        image: Image.asset(
          'assets/images/step1.png',
          width: 200.0,
          height: 200.0,
        ),
        title: 'アカウント登録',
        bodyWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('はじめにアカウント登録にて、あなたの情報を教えて下さい。'),
          ],
        ),
        footer: RoundBackgroundButton(
          onPressed: () => _complete(context),
          label: '登録する',
          color: Colors.white,
          backgroundColor: Colors.blue,
        ),
      ),
    ];
  }

  void _init() async {
    await versionCheck().then((value) {
      if (!value) return;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => UpdaterDialog(),
      );
    });
  }

  void _complete(context) {
    changeScreen(context, RegistrationScreen());
  }

  @override
  void initState() {
    super.initState();
    _init();
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
