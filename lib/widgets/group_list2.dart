import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/group.dart';

class GroupList2 extends StatelessWidget {
  final GroupModel? group;
  final bool? fixed;
  final Function()? onTap;

  GroupList2({
    this.group,
    this.fixed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        title: Text(group?.name ?? ''),
        subtitle: fixed == true ? Text('既定に設定中') : null,
        trailing: Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
