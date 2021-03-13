import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'NotoSansJP',
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 5.0,
      centerTitle: false,
      brightness: Brightness.light,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.black54,
          fontSize: 18.0,
        ),
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

const BoxDecoration kNavigationDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 5.0,
    ),
  ],
);

const TextStyle kTitleTextStyle = TextStyle(
  fontSize: 32.0,
  fontWeight: FontWeight.bold,
);

const TextStyle kSubTitleTextStyle = TextStyle(
  fontSize: 16.0,
);

const TextStyle kDateTextStyle = TextStyle(
  fontSize: 24.0,
);

const TextStyle kTimeTextStyle = TextStyle(
  fontSize: 40.0,
  fontWeight: FontWeight.bold,
  letterSpacing: 10.0,
);
