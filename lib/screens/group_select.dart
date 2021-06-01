import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/widgets/custom_group_list_tile.dart';

class GroupSelect extends StatelessWidget {
  final UserProvider userProvider;
  final String groupId;

  GroupSelect({
    @required this.userProvider,
    @required this.groupId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
        elevation: 0.0,
        centerTitle: true,
        title: Text('会社/組織の切替', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        itemCount: userProvider.groups.length,
        itemBuilder: (_, index) {
          GroupModel _group = userProvider.groups[index];
          return CustomGroupListTile(
            onTap: () {
              userProvider.changeGroup(_group);
              Navigator.of(context, rootNavigator: true).pop();
            },
            group: _group,
            fixed: _group.id == groupId,
          );
        },
      ),
    );
  }
}
