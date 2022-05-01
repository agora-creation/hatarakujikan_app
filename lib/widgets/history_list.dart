import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/models/work_shift.dart';
import 'package:hatarakujikan_app/screens/history_details.dart';

const TextStyle kListDayTextStyle = TextStyle(
  color: Colors.black54,
  fontSize: 15.0,
);

const TextStyle kListDay2TextStyle = TextStyle(
  color: Colors.transparent,
  fontSize: 15.0,
);

class HistoryList extends StatelessWidget {
  final DateTime day;
  final List<WorkModel> dayInWorks;
  final WorkShiftModel? dayInWorkShift;

  HistoryList({
    required this.day,
    required this.dayInWorks,
    this.dayInWorkShift,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        leading: Text(
          dateText('dd (E)', day),
          style: kListDayTextStyle,
        ),
        title: dayInWorks.length > 0
            ? ListView.separated(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                separatorBuilder: (_, index) => Divider(height: 0.0),
                itemCount: dayInWorks.length,
                itemBuilder: (_, index) {
                  WorkModel _work = dayInWorks[index];
                  if (_work.startedAt == _work.endedAt) return Container();
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
                            _work.state,
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
                      HistoryDetailsScreen(work: _work),
                    ),
                  );
                },
              )
            : dayInWorkShift != null
                ? ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(
                          backgroundColor: dayInWorkShift?.stateColor(),
                          label: Text(
                            dayInWorkShift?.state ?? '',
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
