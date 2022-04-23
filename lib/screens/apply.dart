import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/apply_work.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/providers/apply_work.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/screens/apply_work_details.dart';
import 'package:hatarakujikan_app/screens/group_select.dart';
import 'package:hatarakujikan_app/widgets/apply_list_tile.dart';
import 'package:hatarakujikan_app/widgets/expanded_button.dart';

class ApplyScreen extends StatelessWidget {
  final ApplyWorkProvider applyWorkProvider;
  final UserProvider userProvider;

  ApplyScreen({
    required this.applyWorkProvider,
    required this.userProvider,
  });

  @override
  Widget build(BuildContext context) {
    GroupModel? _group = userProvider.group;
    UserModel? _user = userProvider.user;
    List<ApplyWorkModel> _applyWorks = [];

    if (_group == null) return Center(child: Text('会社/組織に所属していません'));
    return Column(
      children: [
        ExpandedButton(
          backgroundColor: Colors.blueGrey,
          label: _group.name,
          color: Colors.white,
          leading: Icon(Icons.store, color: Colors.white),
          trailing: Icon(Icons.arrow_drop_down, color: Colors.white),
          onTap: () => overlayScreen(
            context,
            GroupSelect(userProvider: userProvider),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: applyWorkProvider.streamList(
              groupId: _group.id,
              userId: _user?.id,
            ),
            builder: (context, snapshot) {
              _applyWorks.clear();
              if (snapshot.hasData) {
                for (DocumentSnapshot<Map<String, dynamic>> doc
                    in snapshot.data!.docs) {
                  _applyWorks.add(ApplyWorkModel.fromSnapshot(doc));
                }
              }
              if (_applyWorks.length == 0)
                return Center(child: Text('未承認の申請はありません'));
              return ListView.builder(
                itemCount: _applyWorks.length,
                itemBuilder: (_, index) {
                  ApplyWorkModel _applyWork = _applyWorks[index];
                  return ApplyListTile(
                    state: '記録修正申請',
                    dateTime: _applyWork.createdAt,
                    onTap: () => nextScreen(
                      context,
                      ApplyWorkDetailsScreen(
                        applyWorkProvider: applyWorkProvider,
                        applyWork: _applyWork,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
