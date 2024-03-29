import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/group.dart';

class GroupList extends StatelessWidget {
  final GroupModel? group;
  final bool? selected;
  final Function()? onTap;

  GroupList({
    this.group,
    this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        title: Text(group?.name ?? ''),
        subtitle: selected == true ? Text('選択中') : null,
        trailing:
            selected == true ? Icon(Icons.check, color: Colors.green) : null,
        onTap: onTap,
      ),
    );
  }
}
