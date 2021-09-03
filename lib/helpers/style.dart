import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Color(0xFFFEFFFA),
    fontFamily: 'NotoSansJP',
    appBarTheme: AppBarTheme(
      color: Color(0xFFFEFFFA),
      elevation: 5.0,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: TextStyle(
        color: Colors.black54,
        fontSize: 18.0,
      ),
      iconTheme: IconThemeData(color: Colors.black54),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.black54),
      bodyText2: TextStyle(color: Colors.black54),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

const BoxDecoration kLoginDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF4DD0E1),
      Color(0xFF00BCD4),
    ],
  ),
);

const BoxDecoration kNavigationDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 5.0,
    ),
  ],
);

const BoxDecoration kBottomBorderDecoration = BoxDecoration(
  border: Border(
    bottom: BorderSide(
      width: 1.0,
      color: Color(0xFFE0E0E0),
    ),
  ),
);

const TextStyle kTitleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 32.0,
  fontWeight: FontWeight.bold,
);

const TextStyle kSubTitleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16.0,
);

const TextStyle kListDayTextStyle = TextStyle(
  color: Colors.black54,
  fontSize: 15.0,
);

const TextStyle kListDay2TextStyle = TextStyle(
  color: Colors.transparent,
  fontSize: 15.0,
);

DateTime kMonthFirstDate = DateTime(DateTime.now().year - 1);
DateTime kMonthLastDate = DateTime(DateTime.now().year + 1);
DateTime kDayFirstDate = DateTime.now().subtract(Duration(days: 365));
DateTime kDayLastDate = DateTime.now().add(Duration(days: 365));
