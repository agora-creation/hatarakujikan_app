import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/navigation.dart';
import 'package:hatarakujikan_app/screens/apply_add.dart';
import 'package:hatarakujikan_app/widgets/custom_expanded_button.dart';

class ApplyScreen extends StatefulWidget {
  @override
  _ApplyScreenState createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomExpandedButton(
          buttonColor: Colors.blueGrey,
          labelText: '会社/組織 所属なし',
          labelColor: Colors.white,
          leadingIcon: Icon(Icons.store, color: Colors.white),
          trailingIcon: Icon(Icons.arrow_drop_down, color: Colors.white),
          onTap: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => GroupsDialog(),
            );
          },
        ),
        Expanded(
          child: Center(
            child: Text('申請はありませんでした'),
          ),
        ),
        CustomExpandedButton(
          buttonColor: Colors.blue,
          labelText: '新規申請',
          labelColor: Colors.white,
          leadingIcon: Icon(Icons.add, color: Colors.white),
          trailingIcon: Icon(Icons.arrow_drop_up, color: Colors.white),
          onTap: () => overlayScreen(context, ApplyAddScreen()),
        ),
      ],
    );
  }
}

class GroupsDialog extends StatefulWidget {
  @override
  _GroupsDialogState createState() => _GroupsDialogState();
}

class _GroupsDialogState extends State<GroupsDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '会社/組織 切替',
        style: TextStyle(fontSize: 18.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('キャンセル', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(backgroundColor: Colors.grey),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('はい', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
