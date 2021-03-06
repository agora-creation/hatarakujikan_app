import 'package:flutter/material.dart';

const kMainColor = Color(0xFF795548);
const kSubColor = Color(0xFF8D6E63);
const kMainTextColor = Color(0xFF424242);
const kSubTextColor = Color(0xFF616161);

const TextStyle kTitleTextStyle = TextStyle(
  color: kMainColor,
  fontSize: 32.0,
  fontWeight: FontWeight.bold,
);

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
