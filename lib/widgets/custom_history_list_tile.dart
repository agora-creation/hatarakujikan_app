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
  final List<WorkModel> dayWorks;
  final WorkStateModel dayWorkState;

  CustomHistoryListTile({
    this.user,
    this.day,
    this.dayWorks,
    this.dayWorkState,
  });

  @override
  Widget build(BuildContext context) {
    Color _chipColor = Colors.grey.shade300;
    switch (dayWorkState?.state) {
      case '欠勤':
        _chipColor = Colors.red.shade300;
        break;
      case '特別休暇':
        _chipColor = Colors.green.shade300;
        break;
      case '有給休暇':
        _chipColor = Colors.teal.shade300;
        break;
      case '代休':
        _chipColor = Colors.pink.shade300;
        break;
    }
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        leading: Text(
          '${DateFormat('dd (E)', 'ja').format(day)}',
          style: kListDayTextStyle,
        ),
        title: dayWorks.length > 0
            ? ListView.separated(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                separatorBuilder: (_, index) => Divider(height: 0.0),
                itemCount: dayWorks.length,
                itemBuilder: (_, index) {
                  WorkModel _work = dayWorks[index];
                  if (_work.startedAt != _work.endedAt) {
                    String _startTime = _work.startTime();
                    String _endTime = _work.endTime();
                    String _workTime = _work.workTime();
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
                            style: kListDayTextStyle,
                          ),
                          Text(
                            _endTime,
                            style: kListDayTextStyle,
                          ),
                          Text(
                            _workTime,
                            style: kListDayTextStyle,
                          ),
                        ],
                      ),
                      onTap: () => nextScreen(
                        context,
                        HistoryDetailsScreen(
                          work: _work,
                          user: user,
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            : dayWorkState != null
                ? ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(
                          backgroundColor: _chipColor,
                          label: Text(
                            '${dayWorkState.state}',
                            style: TextStyle(fontSize: 10.0),
                          ),
                        ),
                        Text(
                          '00:00',
                          style: kListDay2TextStyle,
                        ),
                        Text(
                          '00:00',
                          style: kListDay2TextStyle,
                        ),
                        Text(
                          '00:00',
                          style: kListDay2TextStyle,
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
