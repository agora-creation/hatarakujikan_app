import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/apply_pto.dart';
import 'package:hatarakujikan_app/models/apply_work.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/providers/apply_pto.dart';
import 'package:hatarakujikan_app/providers/apply_work.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/screens/apply_pto_details.dart';
import 'package:hatarakujikan_app/screens/apply_select.dart';
import 'package:hatarakujikan_app/screens/apply_work_details.dart';
import 'package:hatarakujikan_app/screens/group_select.dart';
import 'package:hatarakujikan_app/widgets/apply_list.dart';
import 'package:hatarakujikan_app/widgets/expanded_button.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';

class ApplyScreen extends StatelessWidget {
  final ApplyPTOProvider applyPTOProvider;
  final ApplyWorkProvider applyWorkProvider;
  final UserProvider userProvider;

  ApplyScreen({
    required this.applyPTOProvider,
    required this.applyWorkProvider,
    required this.userProvider,
  });

  @override
  Widget build(BuildContext context) {
    GroupModel? _group = userProvider.group;
    UserModel? _user = userProvider.user;
    List<ApplyPTOModel> applyPTOs = [];
    List<ApplyWorkModel> applyWorks = [];

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
          child: StreamBuilder2<QuerySnapshot<Map<String, dynamic>>,
              QuerySnapshot<Map<String, dynamic>>>(
            streams: Tuple2(
              applyPTOProvider.streamList(
                groupId: _group.id,
                userId: _user?.id,
              ),
              applyWorkProvider.streamList(
                groupId: _group.id,
                userId: _user?.id,
              ),
            ),
            builder: (context, snapshot) {
              applyPTOs.clear();
              if (snapshot.item1.hasData) {
                for (DocumentSnapshot<Map<String, dynamic>> doc
                    in snapshot.item1.data!.docs) {
                  applyPTOs.add(ApplyPTOModel.fromSnapshot(doc));
                }
              }
              applyWorks.clear();
              if (snapshot.item2.hasData) {
                for (DocumentSnapshot<Map<String, dynamic>> doc
                    in snapshot.item2.data!.docs) {
                  applyWorks.add(ApplyWorkModel.fromSnapshot(doc));
                }
              }
              List<Widget> _list = [];
              for (ApplyPTOModel _applyPTO in applyPTOs) {
                _list.add(
                  ApplyList(
                    chipText: '有給休暇',
                    chipColor: Colors.teal.shade100,
                    dateTime: dateText('yyyy/MM/dd', _applyPTO.createdAt),
                    onTap: () => nextScreen(
                      context,
                      ApplyPTODetailsScreen(
                        applyPTOProvider: applyPTOProvider,
                        applyPTO: _applyPTO,
                      ),
                    ),
                  ),
                );
              }
              for (ApplyWorkModel _applyWork in applyWorks) {
                _list.add(
                  ApplyList(
                    chipText: '勤怠修正',
                    chipColor: Colors.lightBlue.shade100,
                    dateTime: dateText('yyyy/MM/dd', _applyWork.createdAt),
                    onTap: () => nextScreen(
                      context,
                      ApplyWorkDetailsScreen(
                        applyWorkProvider: applyWorkProvider,
                        applyWork: _applyWork,
                      ),
                    ),
                  ),
                );
              }
              if (_list.length == 0) return Center(child: Text('未承認の申請はありません'));
              return ListView.builder(
                itemCount: _list.length,
                itemBuilder: (_, index) {
                  return _list[index];
                },
              );
            },
          ),
        ),
        ExpandedButton(
          backgroundColor: Colors.blue,
          label: '申請する',
          color: Colors.white,
          leading: Icon(Icons.note_add, color: Colors.white),
          onTap: () => overlayScreen(
            context,
            ApplySelect(group: _group, user: _user),
          ),
        ),
      ],
    );
  }
}
