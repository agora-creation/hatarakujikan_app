import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int? currentIndex;
  final List<BottomNavigationBarItem>? items;
  final Function(int)? onTap;

  CustomBottomNavigationBar({
    this.currentIndex,
    this.items,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kNavigationDecoration,
      child: BottomNavigationBar(
        onTap: onTap,
        backgroundColor: Colors.white,
        currentIndex: currentIndex ?? 0,
        fixedColor: Colors.cyan.shade700,
        type: BottomNavigationBarType.fixed,
        items: items ?? [],
      ),
    );
  }
}
