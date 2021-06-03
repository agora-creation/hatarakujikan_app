import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/breaks.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/providers/apply_work.dart';
import 'package:hatarakujikan_app/widgets/custom_date_button.dart';
import 'package:hatarakujikan_app/widgets/custom_icon_label.dart';
import 'package:hatarakujikan_app/widgets/custom_time_button.dart';
import 'package:hatarakujikan_app/widgets/error_message.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ApplyWorkScreen extends StatefulWidget {
  final WorkModel work;

  ApplyWorkScreen({@required this.work});

  @override
  _ApplyWorkScreenState createState() => _ApplyWorkScreenState();
}

class _ApplyWorkScreenState extends State<ApplyWorkScreen> {
  WorkModel work;

  void _init() async {
    setState(() => work = widget.work);
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    final applyWorkProvider = Provider.of<ApplyWorkProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue.shade100,
        elevation: 0.0,
        centerTitle: true,
        title: Text('記録修正申請', style: TextStyle(color: Colors.black54)),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: Icon(Icons.close, color: Colors.black54),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          Text('修正したい日時に変更し、最後に「申請する」ボタンを押してください。'),
          SizedBox(height: 16.0),
          CustomIconLabel(
            icon: Icon(Icons.run_circle, color: Colors.blue),
            labelText: '出勤時間',
          ),
          SizedBox(height: 4.0),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: CustomDateButton(
                  onTap: () async {
                    final DateTime _selected = await showDatePicker(
                      context: context,
                      initialDate: work.startedAt,
                      firstDate: DateTime.now().subtract(Duration(days: 365)),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                    );
                    if (_selected != null) {
                      DateTime _dateTime = DateTime.parse(
                          '${DateFormat(formatY_M_D).format(_selected)} ${DateFormat(formatHM).format(work.startedAt)}:00.000');
                      setState(() => work.startedAt = _dateTime);
                    }
                  },
                  labelText: '${DateFormat(formatYMD).format(work.startedAt)}',
                ),
              ),
              SizedBox(width: 4.0),
              Expanded(
                flex: 2,
                child: CustomTimeButton(
                  onTap: () async {
                    final int _hour =
                        int.parse(DateFormat('H').format(work.startedAt));
                    final int _minute =
                        int.parse(DateFormat('m').format(work.startedAt));
                    final TimeOfDay _selected = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: _hour, minute: _minute),
                    );
                    if (_selected != null) {
                      DateTime _dateTime = DateTime.parse(
                          '${DateFormat(formatY_M_D).format(work.startedAt)} ${_selected.format(context)}:00.000');
                      setState(() => work.startedAt = _dateTime);
                    }
                  },
                  labelText: '${DateFormat(formatHM).format(work.startedAt)}',
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          work.breaks.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: work.breaks.length,
                  itemBuilder: (_, index) {
                    BreaksModel _breaks = work.breaks[index];
                    return Column(
                      children: [
                        CustomIconLabel(
                          icon: Icon(Icons.run_circle, color: Colors.orange),
                          labelText: '休憩開始時間',
                        ),
                        SizedBox(height: 4.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: CustomDateButton(
                                onTap: () async {
                                  final DateTime _selected =
                                      await showDatePicker(
                                    context: context,
                                    initialDate: _breaks.startedAt,
                                    firstDate: DateTime.now()
                                        .subtract(Duration(days: 365)),
                                    lastDate:
                                        DateTime.now().add(Duration(days: 365)),
                                  );
                                  if (_selected != null) {
                                    DateTime _dateTime = DateTime.parse(
                                        '${DateFormat(formatY_M_D).format(_selected)} ${DateFormat(formatHM).format(_breaks.startedAt)}:00.000');
                                    setState(
                                        () => _breaks.startedAt = _dateTime);
                                  }
                                },
                                labelText:
                                    '${DateFormat(formatYMD).format(_breaks.startedAt)}',
                              ),
                            ),
                            SizedBox(width: 4.0),
                            Expanded(
                              flex: 2,
                              child: CustomTimeButton(
                                onTap: () async {
                                  final int _hour = int.parse(DateFormat('H')
                                      .format(_breaks.startedAt));
                                  final int _minute = int.parse(DateFormat('m')
                                      .format(_breaks.startedAt));
                                  final TimeOfDay _selected =
                                      await showTimePicker(
                                    context: context,
                                    initialTime:
                                        TimeOfDay(hour: _hour, minute: _minute),
                                  );
                                  if (_selected != null) {
                                    DateTime _dateTime = DateTime.parse(
                                        '${DateFormat(formatY_M_D).format(_breaks.startedAt)} ${_selected.format(context)}:00.000');
                                    setState(
                                        () => _breaks.startedAt = _dateTime);
                                  }
                                },
                                labelText:
                                    '${DateFormat(formatHM).format(_breaks.startedAt)}',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        CustomIconLabel(
                          icon: Icon(Icons.run_circle_outlined,
                              color: Colors.orange),
                          labelText: '休憩終了時間',
                        ),
                        SizedBox(height: 4.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: CustomDateButton(
                                onTap: () async {
                                  final DateTime _selected =
                                      await showDatePicker(
                                    context: context,
                                    initialDate: _breaks.endedAt,
                                    firstDate: DateTime.now()
                                        .subtract(Duration(days: 365)),
                                    lastDate:
                                        DateTime.now().add(Duration(days: 365)),
                                  );
                                  if (_selected != null) {
                                    DateTime _dateTime = DateTime.parse(
                                        '${DateFormat(formatY_M_D).format(_selected)} ${DateFormat(formatHM).format(_breaks.endedAt)}:00.000');
                                    setState(() => _breaks.endedAt = _dateTime);
                                  }
                                },
                                labelText:
                                    '${DateFormat(formatYMD).format(_breaks.endedAt)}',
                              ),
                            ),
                            SizedBox(width: 4.0),
                            Expanded(
                              flex: 2,
                              child: CustomTimeButton(
                                onTap: () async {
                                  final int _hour = int.parse(
                                      DateFormat('H').format(_breaks.endedAt));
                                  final int _minute = int.parse(
                                      DateFormat('m').format(_breaks.endedAt));
                                  final TimeOfDay _selected =
                                      await showTimePicker(
                                    context: context,
                                    initialTime:
                                        TimeOfDay(hour: _hour, minute: _minute),
                                  );
                                  if (_selected != null) {
                                    DateTime _dateTime = DateTime.parse(
                                        '${DateFormat(formatY_M_D).format(_breaks.endedAt)} ${_selected.format(context)}:00.000');
                                    setState(() => _breaks.endedAt = _dateTime);
                                  }
                                },
                                labelText:
                                    '${DateFormat(formatHM).format(_breaks.endedAt)}',
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                )
              : Container(),
          SizedBox(height: 8.0),
          CustomIconLabel(
            icon: Icon(Icons.run_circle, color: Colors.red),
            labelText: '退勤時間',
          ),
          SizedBox(height: 4.0),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: CustomDateButton(
                  onTap: () async {
                    final DateTime _selected = await showDatePicker(
                      context: context,
                      initialDate: work.endedAt,
                      firstDate: DateTime.now().subtract(Duration(days: 365)),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                    );
                    if (_selected != null) {
                      DateTime _dateTime = DateTime.parse(
                          '${DateFormat(formatY_M_D).format(_selected)} ${DateFormat(formatHM).format(work.endedAt)}:00.000');
                      setState(() => work.endedAt = _dateTime);
                    }
                  },
                  labelText: '${DateFormat(formatYMD).format(work.endedAt)}',
                ),
              ),
              SizedBox(width: 4.0),
              Expanded(
                flex: 2,
                child: CustomTimeButton(
                  onTap: () async {
                    final int _hour =
                        int.parse(DateFormat('H').format(work.endedAt));
                    final int _minute =
                        int.parse(DateFormat('m').format(work.endedAt));
                    final TimeOfDay _selected = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: _hour, minute: _minute),
                    );
                    if (_selected != null) {
                      DateTime _dateTime = DateTime.parse(
                          '${DateFormat(formatY_M_D).format(work.endedAt)} ${_selected.format(context)}:00.000');
                      setState(() => work.endedAt = _dateTime);
                    }
                  },
                  labelText: '${DateFormat(formatHM).format(work.endedAt)}',
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          RoundBackgroundButton(
            onPressed: () async {
              if (!await applyWorkProvider.create(work: work)) {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => ErrorMessage('申請に失敗しました。'),
                );
                return;
              }
              Navigator.of(context, rootNavigator: true).pop();
            },
            labelText: '申請する',
            labelColor: Colors.white,
            backgroundColor: Colors.blue,
          ),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }
}
