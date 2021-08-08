import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/apply_work.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/screens/apply_work_details.dart';
import 'package:hatarakujikan_app/screens/group_select.dart';
import 'package:hatarakujikan_app/widgets/custom_apply_list_tile.dart';
import 'package:hatarakujikan_app/widgets/custom_expanded_button.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';

class ApplyScreen extends StatefulWidget {
  final UserProvider userProvider;

  ApplyScreen({@required this.userProvider});

  @override
  _ApplyScreenState createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
        .collection('applyWork')
        .where('groupId', isEqualTo: widget.userProvider.group?.id)
        .where('userId', isEqualTo: widget.userProvider.user?.id)
        .where('approval', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots();
    List<ApplyWorkModel> applyWorks = [];

    return widget.userProvider.group != null
        ? Column(
            children: [
              CustomExpandedButton(
                backgroundColor: Colors.blueGrey,
                label: widget.userProvider.group?.name,
                color: Colors.white,
                leading: Icon(Icons.store, color: Colors.white),
                trailing: Icon(Icons.arrow_drop_down, color: Colors.white),
                onTap: () => overlayScreen(
                  context,
                  GroupSelect(userProvider: widget.userProvider),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Loading(color: Colors.cyan);
                    }
                    applyWorks.clear();
                    for (DocumentSnapshot applyWork in snapshot.data.docs) {
                      applyWorks.add(ApplyWorkModel.fromSnapshot(applyWork));
                    }
                    if (applyWorks.length > 0) {
                      return ListView.builder(
                        itemCount: applyWorks.length,
                        itemBuilder: (_, index) {
                          ApplyWorkModel _applyWork = applyWorks[index];
                          return CustomApplyListTile(
                            onTap: () => nextScreen(
                              context,
                              ApplyWorkDetailsScreen(applyWork: _applyWork),
                            ),
                            state: '記録修正申請',
                            dateTime: _applyWork.createdAt,
                          );
                        },
                      );
                    } else {
                      return Center(child: Text('未承認の申請はありません'));
                    }
                  },
                ),
              ),
            ],
          )
        : Center(child: Text('会社/組織に所属していません'));
  }
}
