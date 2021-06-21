import 'dart:math';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

void nextScreen(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void changeScreen(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
      fullscreenDialog: true,
    ),
  );
}

void overlayScreen(BuildContext context, Widget widget) {
  showMaterialModalBottomSheet(
    expand: true,
    context: context,
    builder: (context) => widget,
  );
}

String randomString(int length) {
  const _randomChars =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  const _charsLength = _randomChars.length;
  final rand = Random();
  final codeUnits = List.generate(
    length,
    (index) {
      final n = rand.nextInt(_charsLength);
      return _randomChars.codeUnitAt(n);
    },
  );
  return new String.fromCharCodes(codeUnits);
}

Future<String> getPrefs() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString('groupId') ?? '';
}

Future<void> setPrefs(String value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString('groupId', value);
}

Future<void> removePrefs() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.remove('groupId');
}

String addTime(String left, String right) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  List<String> _lefts = left.split(':');
  List<String> _rights = right.split(':');
  double _hm = (int.parse(_lefts.last) + int.parse(_rights.last)) / 60;
  int _m = (int.parse(_lefts.last) + int.parse(_rights.last)) % 60;
  int _h = (int.parse(_lefts.first) + int.parse(_rights.first)) + _hm.toInt();
  if (_h.toString().length == 1) {
    return '${twoDigits(_h)}:${twoDigits(_m)}';
  } else {
    return '$_h:${twoDigits(_m)}';
  }
}

String subTime(String left, String right) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  List<String> _lefts = left.split(':');
  List<String> _rights = right.split(':');
  double _hm = (int.parse(_lefts.last) - int.parse(_rights.last)) / 60;
  int _m = (int.parse(_lefts.last) - int.parse(_rights.last)) % 60;
  int _h = int.parse(_lefts.first) - int.parse(_rights.first) + _hm.toInt();
  if (_h.toString().length == 1) {
    return '${twoDigits(_h)}:${twoDigits(_m)}';
  } else {
    return '$_h:${twoDigits(_m)}';
  }
}

// 法定内時間/法定外時間
List<String> legalList(String workTime, int legal) {
  String _legal = '0$legal:00';
  String _legalTime = '00:00';
  String _nonLegalTime = '00:00';
  List<String> _hm = workTime.split(':');
  if (legal <= int.parse(_hm.first)) {
    // 法定内時間
    _legalTime = addTime(_legalTime, _legal);
    // 法定外時間
    String _tmp = subTime(workTime, _legal);
    _nonLegalTime = addTime(_nonLegalTime, _tmp);
  } else {
    // 法定内時間
    _legalTime = addTime(_legalTime, workTime);
    // 法定外時間
    _nonLegalTime = addTime(_nonLegalTime, '00:00');
  }
  return [_legalTime, _nonLegalTime];
}
