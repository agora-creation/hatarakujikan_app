import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/group.dart';

class CustomGroupSelectListTile extends StatelessWidget {
  final GroupModel? group;
  final bool? selected;
  final Function()? onTap;

  CustomGroupSelectListTile({
    this.group,
    this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String? groupName = group?.name;
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        title: Text(groupName!),
        subtitle: selected! ? Text('選択中') : null,
        trailing: selected! ? Icon(Icons.check, color: Colors.green) : null,
        onTap: onTap,
      ),
    );
  }
}
