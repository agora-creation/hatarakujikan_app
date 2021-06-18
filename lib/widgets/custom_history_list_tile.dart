import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/screens/history_details.dart';
import 'package:intl/intl.dart';

class CustomHistoryListTile extends StatelessWidget {
  final UserModel user;
  final DateTime day;
  final List<WorkModel> works;

  CustomHistoryListTile({
    this.user,
    this.day,
    this.works,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        leading: Text('${DateFormat('dd (E)', 'ja').format(day)}'),
        title: works.length > 0
            ? ListView.separated(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                separatorBuilder: (_, index) => Divider(height: 0.0),
                itemCount: works.length,
                itemBuilder: (_, index) {
                  WorkModel _work = works[index];
                  String _startTime =
                      '${DateFormat('HH:mm').format(_work.startedAt)}';
                  String _endTime = '---:---';
                  if (_work.startedAt != _work.endedAt) {
                    _endTime = '${DateFormat('HH:mm').format(_work.endedAt)}';
                  }
                  String _workTime = '---:---';
                  if (_work.startedAt != _work.endedAt) {
                    _workTime = '${_work.workTime()}';
                  }

                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          _startTime,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          _endTime,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          _workTime,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    trailing: _work.startedAt != _work.endedAt
                        ? Icon(Icons.chevron_right)
                        : Icon(Icons.chevron_right, color: Colors.transparent),
                    onTap: _work.startedAt != _work.endedAt
                        ? () => nextScreen(
                              context,
                              HistoryDetailsScreen(work: _work, user: user),
                            )
                        : null,
                  );
                },
              )
            : Container(),
      ),
    );
  }
}
