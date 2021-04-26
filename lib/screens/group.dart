import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/widgets/custom_total_button.dart';

class GroupScreen extends StatefulWidget {
  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text('会社/グループの登録がありません'),
          ),
        ),
        CustomTotalButton(
          title: '合計時間を確認',
          onTap: () {},
        ),
      ],
    );
  }
}
