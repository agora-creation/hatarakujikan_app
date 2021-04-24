import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/user_work.dart';
import 'package:intl/intl.dart';

class CustomHistoryListTile extends StatelessWidget {
  final DateTime day;
  final List<UserWorkModel> works;
  final Function onTap;

  CustomHistoryListTile({
    this.day,
    this.works,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: GestureDetector(
        onTap: onTap,
        child: ListTile(
          leading: Text('${DateFormat('dd (E)', 'ja').format(day)}'),
          title: works.length > 0
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  separatorBuilder: (_, index) => Divider(height: 0.0),
                  itemCount: works.length,
                  itemBuilder: (_, index) {
                    UserWorkModel _work = works[index];
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '出勤',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                ),
                              ),
                              Text(
                                '${DateFormat('HH:mm').format(_work.startedAt)}',
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '退勤',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                ),
                              ),
                              Text(
                                '${DateFormat('HH:mm').format(_work.endedAt)}',
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '勤務',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                ),
                              ),
                              Text(
                                '${_work.diffTime()}',
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Container(),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
