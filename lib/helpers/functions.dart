import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/date_machine_util.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
  return String.fromCharCodes(codeUnits);
}

Future<String> getPrefs({String key}) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString(key) ?? '';
}

Future<void> setPrefs({String key, String value}) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString(key, value);
}

Future<void> removePrefs({String key}) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.remove(key);
}

DateTime rebuildDate(DateTime date, DateTime time) {
  String _date = '${DateFormat('yyyy-MM-dd').format(date)}';
  String _time = '${DateFormat('HH:mm').format(time)}:00.000';
  return DateTime.parse('$_date $_time');
}

DateTime rebuildTime(BuildContext context, DateTime date, TimeOfDay time) {
  String _date = '${DateFormat('yyyy-MM-dd').format(date)}';
  String _time = '${time.format(context).padLeft(5, '0')}:00.000';
  return DateTime.parse('$_date $_time');
}

List<int> timeToInt(DateTime dateTime) {
  String _h = '${DateFormat('H').format(dateTime)}';
  String _m = '${DateFormat('m').format(dateTime)}';
  return [int.parse(_h), int.parse(_m)];
}

String twoDigits(int n) => n.toString().padLeft(2, '0');

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
  // 時 → 分
  int _leftM = (int.parse(_lefts.first) * 60) + int.parse(_lefts.last);
  int _rightM = (int.parse(_rights.first) * 60) + int.parse(_rights.last);
  // 分で引き算
  int _diffM = _leftM - _rightM;
  // 分 → 時
  double _h = _diffM / 60;
  int _m = _diffM % 60;
  return '${twoDigits(_h.toInt())}:${twoDigits(_m)}';
}

// エリアチェック
bool areaCheck(
  double areaLat,
  double areaLon,
  double areaRange,
  List<double> locations,
) {
  // 1mあたりの度数に変換
  double rate = areaRange * 0.00001;
  double minLat = double.parse((areaLat - rate).toStringAsFixed(5));
  double maxLat = double.parse((areaLat + rate).toStringAsFixed(5));
  double minLon = double.parse((areaLon - rate).toStringAsFixed(5));
  double maxLon = double.parse((areaLon + rate).toStringAsFixed(5));
  if (locations.first > minLat &&
      locations.first < maxLat &&
      locations.last > minLon &&
      locations.last < maxLon) {
    return true;
  } else {
    return false;
  }
}

// DateTime => Timestamp
Timestamp convertTimestamp(DateTime date, bool end) {
  String _dateTime = '${DateFormat('yyyy-MM-dd').format(date)} 00:00:00.000';
  if (end) {
    _dateTime = '${DateFormat('yyyy-MM-dd').format(date)} 23:59:59.999';
  }
  return Timestamp.fromMillisecondsSinceEpoch(
    DateTime.parse(_dateTime).millisecondsSinceEpoch,
  );
}

// 1ヶ月間の配列作成
List<DateTime> generateDays(DateTime month) {
  List<DateTime> _days = [];
  var _dateMap = DateMachineUtil.getMonthDate(month, 0);
  DateTime _start = DateTime.parse('${_dateMap['start']}');
  DateTime _end = DateTime.parse('${_dateMap['end']}');
  for (int i = 0; i <= _end.difference(_start).inDays; i++) {
    _days.add(_start.add(Duration(days: i)));
  }
  return _days;
}

// 通常時間と深夜時間に分ける関数
List<DateTime> separateDayNight({
  DateTime startedAt,
  DateTime endedAt,
  String nightStart,
  String nightEnd,
}) {
  DateTime _dayS;
  DateTime _dayE;
  DateTime _nightS;
  DateTime _nightE;
  String _startedDate = '${DateFormat('yyyy-MM-dd').format(startedAt)}';
  String _endedDate = '${DateFormat('yyyy-MM-dd').format(endedAt)}';
  DateTime _ss = DateTime.parse('$_startedDate $nightStart:00.000');
  DateTime _se = DateTime.parse('$_startedDate $nightEnd:00.000');
  DateTime _es = DateTime.parse('$_endedDate $nightStart:00.000');
  DateTime _ee = DateTime.parse('$_endedDate $nightEnd:00.000');
  // 開始時間は通常時間帯
  if (startedAt.millisecondsSinceEpoch < _ss.millisecondsSinceEpoch &&
      startedAt.millisecondsSinceEpoch > _se.millisecondsSinceEpoch) {
    // 終了時間は日跨ぎ
    if (DateTime.parse('$_startedDate') != DateTime.parse('$_endedDate')) {
      // 退勤時間は通常時間帯
      if (endedAt.millisecondsSinceEpoch < _es.millisecondsSinceEpoch &&
          endedAt.millisecondsSinceEpoch > _ee.millisecondsSinceEpoch) {
        _dayS = startedAt;
        _dayE = endedAt;
        _nightS = _ee;
        _nightE = _ee;
      } else {
        _dayS = startedAt;
        _dayE = _ss;
        _nightS = _ss;
        _nightE = endedAt;
      }
    } else {
      // 終了時間は日跨ぎではない
      // 退勤時間は通常時間帯
      if (endedAt.millisecondsSinceEpoch < _es.millisecondsSinceEpoch &&
          endedAt.millisecondsSinceEpoch > _ee.millisecondsSinceEpoch) {
        _dayS = startedAt;
        _dayE = endedAt;
        _nightS = _ee;
        _nightE = _ee;
      } else {
        _dayS = startedAt;
        _dayE = _ss;
        _nightS = _ss;
        _nightE = endedAt;
      }
    }
  } else {
    // 開始時間は深夜時間帯
    // 終了時間は日跨ぎ
    if (DateTime.parse('$_startedDate') != DateTime.parse('$_endedDate')) {
      // 終了時間は通常時間帯
      if (endedAt.millisecondsSinceEpoch < _es.millisecondsSinceEpoch &&
          endedAt.millisecondsSinceEpoch > _ee.millisecondsSinceEpoch) {
        _nightS = startedAt;
        _nightE = _ee;
        _dayS = _ee;
        _dayE = endedAt;
      } else {
        _nightS = startedAt;
        _nightE = endedAt;
        _dayS = _ee;
        _dayE = _ee;
      }
    } else {
      // 終了時間は日跨ぎではない
      // 終了時間は通常時間帯
      if (endedAt.millisecondsSinceEpoch < _es.millisecondsSinceEpoch &&
          endedAt.millisecondsSinceEpoch > _ee.millisecondsSinceEpoch) {
        _nightS = _ee;
        _nightE = _ee;
        _dayS = _ee;
        _dayE = _ee;
      } else {
        _nightS = startedAt;
        _nightE = endedAt;
        _dayS = _ee;
        _dayE = _ee;
      }
    }
  }
  return [_dayS, _dayE, _nightS, _nightE];
}

// バージョンチェック
Future<bool> versionCheck() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  int currentVersion = int.parse(packageInfo.buildNumber);
  final RemoteConfig remoteConfig = RemoteConfig.instance;
  try {
    await remoteConfig.fetch();
    await remoteConfig.fetchAndActivate();
    final remoteConfigAppVersionKey = Platform.isIOS
        ? 'app_ios_required_semver'
        : 'app_android_required_semver';
    int newVersion = remoteConfig.getInt(remoteConfigAppVersionKey);
    if (newVersion > currentVersion) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

// ストアURL
const String iosUrl = 'https://itunes.apple.com/jp/app/id1571895381?mt=8';
const String androidUrl =
    'https://play.google.com/store/apps/details?id=com.agoracreation.hatarakujikan_app';

void launchUpdate() async {
  String _url;
  if (Platform.isIOS) {
    _url = iosUrl;
  } else {
    _url = androidUrl;
  }
  if (await canLaunch(_url)) {
    await launch(_url);
  } else {
    throw 'Could not launch $_url';
  }
}
