import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/models/work_state.dart';
import 'package:hatarakujikan_app/screens/history_details.dart';
import 'package:intl/intl.dart';

class CustomHistoryListTile extends StatelessWidget {
  final UserModel user;
  final DateTime day;
  final List<WorkModel> works;
  final WorkStateModel workState;

  CustomHistoryListTile({
    this.user,
    this.day,
    this.works,
    this.workState,
  });

  @override
  Widget build(BuildContext context) {
    Color _chipColor = Colors.grey.shade300;
    if (workState?.state == '欠勤') {
      _chipColor = Colors.red.shade300;
    } else if (workState?.state == '特別休暇') {
      _chipColor = Colors.green.shade300;
    } else if (workState?.state == '有給休暇') {
      _chipColor = Colors.teal.shade300;
    }

    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        leading: Text(
          '${DateFormat('dd (E)', 'ja').format(day)}',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 15.0,
          ),
        ),
        title: works.length > 0
            ? ListView.separated(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                separatorBuilder: (_, index) => Divider(height: 0.0),
                itemCount: works.length,
                itemBuilder: (_, index) {
                  WorkModel _work = works[index];
                  String _startTime = _work.startTime();
                  String _endTime = '00:00';
                  String _workTime = '00:00';
                  if (_work.startedAt != _work.endedAt) {
                    _endTime = _work.endTime();
                    _workTime = _work.workTime();
                  }
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(
                          backgroundColor: _chipColor,
                          label: Text(
                            '${_work.state}',
                            style: TextStyle(fontSize: 10.0),
                          ),
                        ),
                        Text(
                          _startTime,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          _endTime,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          _workTime,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                    onTap: _work.startedAt != _work.endedAt
                        ? () => nextScreen(
                              context,
                              HistoryDetailsScreen(
                                work: _work,
                                user: user,
                              ),
                            )
                        : null,
                  );
                },
              )
            : workState != null
                ? ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(
                          backgroundColor: _chipColor,
                          label: Text(
                            '${workState.state}',
                            style: TextStyle(fontSize: 10.0),
                          ),
                        ),
                        Text(
                          '00:00',
                          style: TextStyle(
                            color: Colors.transparent,
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          '00:00',
                          style: TextStyle(
                            color: Colors.transparent,
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          '00:00',
                          style: TextStyle(
                            color: Colors.transparent,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                    onTap: null,
                  )
                : Container(),
      ),
    );
  }
}
