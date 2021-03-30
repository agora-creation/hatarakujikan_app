import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
