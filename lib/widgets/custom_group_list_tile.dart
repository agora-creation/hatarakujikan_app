import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/group.dart';

class CustomGroupListTile extends StatelessWidget {
  final GroupModel? group;
  final bool? fixed;
  final Function()? onTap;

  CustomGroupListTile({
    this.group,
    this.fixed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String? groupName = group?.name;
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        title: Text(groupName!),
        subtitle: fixed! ? Text('既定に設定中') : null,
        trailing: Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
