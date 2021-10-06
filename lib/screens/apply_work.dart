import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/dialogs.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/models/breaks.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/providers/apply_work.dart';
import 'package:hatarakujikan_app/widgets/custom_date_button.dart';
import 'package:hatarakujikan_app/widgets/custom_icon_label.dart';
import 'package:hatarakujikan_app/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_app/widgets/custom_time_button.dart';
import 'package:hatarakujikan_app/widgets/error_dialog.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ApplyWorkScreen extends StatefulWidget {
  final UserModel user;
  final WorkModel work;

  ApplyWorkScreen({
    @required this.user,
    @required this.work,
  });

  @override
  _ApplyWorkScreenState createState() => _ApplyWorkScreenState();
}

class _ApplyWorkScreenState extends State<ApplyWorkScreen> {
  WorkModel _work;
  TextEditingController reason = TextEditingController();

  void _init() async {
    checkUpdate().then((value) {
      if (!value) return;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => UpdaterDialog(),
      );
    });
    setState(() => _work = widget.work);
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
            label: '出勤日時',
          ),
          SizedBox(height: 4.0),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: CustomDateButton(
                  onTap: () async {
                    DateTime _selected = await showDatePicker(
                      context: context,
                      initialDate: _work.startedAt,
                      firstDate: kDayFirstDate,
                      lastDate: kDayLastDate,
                    );
                    if (_selected != null) {
                      _selected = rebuildDate(_selected, _work.startedAt);
                      setState(() => _work.startedAt = _selected);
                    }
                  },
                  label: '${DateFormat('yyyy/MM/dd').format(_work.startedAt)}',
                ),
              ),
              SizedBox(width: 4.0),
              Expanded(
                flex: 2,
                child: CustomTimeButton(
                  onTap: () async {
                    TimeOfDay _selected = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                        hour: timeToInt(_work.startedAt)[0],
                        minute: timeToInt(_work.startedAt)[1],
                      ),
                    );
                    if (_selected != null) {
                      DateTime _dateTime = rebuildTime(
                        context,
                        _work.startedAt,
                        _selected,
                      );
                      setState(() => _work.startedAt = _dateTime);
                    }
                  },
                  label: '${DateFormat('HH:mm').format(_work.startedAt)}',
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          _work.breaks.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: _work.breaks.length,
                  itemBuilder: (_, index) {
                    BreaksModel _breaks = _work.breaks[index];
                    return Column(
                      children: [
                        CustomIconLabel(
                          icon: Icon(Icons.run_circle, color: Colors.orange),
                          label: '休憩開始日時',
                        ),
                        SizedBox(height: 4.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: CustomDateButton(
                                onTap: () async {
                                  DateTime _selected = await showDatePicker(
                                    context: context,
                                    initialDate: _breaks.startedAt,
                                    firstDate: kDayFirstDate,
                                    lastDate: kDayLastDate,
                                  );
                                  if (_selected != null) {
                                    _selected = rebuildDate(
                                        _selected, _breaks.startedAt);
                                    setState(
                                        () => _breaks.startedAt = _selected);
                                  }
                                },
                                label:
                                    '${DateFormat('yyyy/MM/dd').format(_breaks.startedAt)}',
                              ),
                            ),
                            SizedBox(width: 4.0),
                            Expanded(
                              flex: 2,
                              child: CustomTimeButton(
                                onTap: () async {
                                  TimeOfDay _selected = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(
                                      hour: timeToInt(_breaks.startedAt)[0],
                                      minute: timeToInt(_breaks.startedAt)[1],
                                    ),
                                  );
                                  if (_selected != null) {
                                    DateTime _dateTime = rebuildTime(
                                      context,
                                      _breaks.startedAt,
                                      _selected,
                                    );
                                    setState(
                                        () => _breaks.startedAt = _dateTime);
                                  }
                                },
                                label:
                                    '${DateFormat('HH:mm').format(_breaks.startedAt)}',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        CustomIconLabel(
                          icon: Icon(
                            Icons.run_circle_outlined,
                            color: Colors.orange,
                          ),
                          label: '休憩終了日時',
                        ),
                        SizedBox(height: 4.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: CustomDateButton(
                                onTap: () async {
                                  DateTime _selected = await showDatePicker(
                                    context: context,
                                    initialDate: _breaks.endedAt,
                                    firstDate: kDayFirstDate,
                                    lastDate: kDayLastDate,
                                  );
                                  if (_selected != null) {
                                    _selected =
                                        rebuildDate(_selected, _breaks.endedAt);
                                    setState(() => _breaks.endedAt = _selected);
                                  }
                                },
                                label:
                                    '${DateFormat('yyyy/MM/dd').format(_breaks.endedAt)}',
                              ),
                            ),
                            SizedBox(width: 4.0),
                            Expanded(
                              flex: 2,
                              child: CustomTimeButton(
                                onTap: () async {
                                  TimeOfDay _selected = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(
                                      hour: timeToInt(_breaks.endedAt)[0],
                                      minute: timeToInt(_breaks.endedAt)[1],
                                    ),
                                  );
                                  if (_selected != null) {
                                    DateTime _dateTime = rebuildTime(
                                      context,
                                      _breaks.endedAt,
                                      _selected,
                                    );
                                    setState(() => _breaks.endedAt = _dateTime);
                                  }
                                },
                                label:
                                    '${DateFormat('HH:mm').format(_breaks.endedAt)}',
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
            label: '退勤日時',
          ),
          SizedBox(height: 4.0),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: CustomDateButton(
                  onTap: () async {
                    DateTime _selected = await showDatePicker(
                      context: context,
                      initialDate: _work.endedAt,
                      firstDate: kDayFirstDate,
                      lastDate: kDayLastDate,
                    );
                    if (_selected != null) {
                      _selected = rebuildDate(_selected, _work.endedAt);
                      setState(() => _work.endedAt = _selected);
                    }
                  },
                  label: '${DateFormat('yyyy/MM/dd').format(_work.endedAt)}',
                ),
              ),
              SizedBox(width: 4.0),
              Expanded(
                flex: 2,
                child: CustomTimeButton(
                  onTap: () async {
                    TimeOfDay _selected = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                        hour: timeToInt(_work.endedAt)[0],
                        minute: timeToInt(_work.endedAt)[1],
                      ),
                    );
                    if (_selected != null) {
                      DateTime _dateTime = rebuildTime(
                        context,
                        _work.endedAt,
                        _selected,
                      );
                      setState(() => _work.endedAt = _dateTime);
                    }
                  },
                  label: '${DateFormat('HH:mm').format(_work.endedAt)}',
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          CustomTextFormField(
            controller: reason,
            obscureText: false,
            textInputType: TextInputType.multiline,
            maxLines: null,
            label: '事由',
            color: Colors.black54,
            prefix: Icons.short_text,
            suffix: null,
            onTap: null,
          ),
          SizedBox(height: 16.0),
          RoundBackgroundButton(
            onPressed: () async {
              if (!await applyWorkProvider.create(
                user: widget.user,
                work: _work,
                reason: reason.text.trim(),
              )) {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => ErrorDialog('申請に失敗しました。'),
                );
                return;
              }
              Navigator.of(context, rootNavigator: true).pop();
            },
            label: '申請する',
            color: Colors.white,
            backgroundColor: Colors.blue,
          ),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }
}
