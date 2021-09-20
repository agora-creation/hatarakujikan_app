import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/models/work_shift.dart';
import 'package:hatarakujikan_app/screens/history_details.dart';
import 'package:intl/intl.dart';

class CustomHistoryListTile extends StatelessWidget {
  final UserModel user;
  final DateTime day;
  final List<WorkModel> dayWorks;
  final WorkShiftModel dayWorkShift;

  CustomHistoryListTile({
    this.user,
    this.day,
    this.dayWorks,
    this.dayWorkShift,
  });

  @override
  Widget build(BuildContext context) {
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
                            backgroundColor: Colors.grey.shade300,
                            label: Text(
                              '${_work.state}',
                              style: TextStyle(fontSize: 10.0),
                            ),
                          ),
                          Text(_startTime, style: kListDayTextStyle),
                          Text(_endTime, style: kListDayTextStyle),
                          Text(_workTime, style: kListDayTextStyle),
                        ],
                      ),
                      onTap: () => nextScreen(
                        context,
                        HistoryDetailsScreen(
                          user: user,
                          work: _work,
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            : dayWorkShift != null
                ? ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(
                          backgroundColor: dayWorkShift.stateColor(),
                          label: Text(
                            '${dayWorkShift.state}',
                            style: TextStyle(fontSize: 10.0),
                          ),
                        ),
                        Text('00:00', style: kListDay2TextStyle),
                        Text('00:00', style: kListDay2TextStyle),
                        Text('00:00', style: kListDay2TextStyle),
                      ],
                    ),
                    onTap: null,
                  )
                : Container(),
      ),
    );
  }
}
