import 'package:flutter/material.dart';
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
  final WorkModel work;
  final UserModel user;

  ApplyWorkScreen({
    @required this.work,
    @required this.user,
  });

  @override
  _ApplyWorkScreenState createState() => _ApplyWorkScreenState();
}

class _ApplyWorkScreenState extends State<ApplyWorkScreen> {
  WorkModel work;
  TextEditingController reason = TextEditingController();

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
                      initialDate: work.startedAt,
                      firstDate: kDayFirstDate,
                      lastDate: kDayLastDate,
                    );
                    if (_selected != null) {
                      String _date =
                          '${DateFormat('yyyy-MM-dd').format(_selected)}';
                      String _time =
                          '${DateFormat('HH:mm').format(work.startedAt)}:00.000';
                      DateTime _dateTime = DateTime.parse('$_date $_time');
                      setState(() => work.startedAt = _dateTime);
                    }
                  },
                  label: '${DateFormat('yyyy/MM/dd').format(work.startedAt)}',
                ),
              ),
              SizedBox(width: 4.0),
              Expanded(
                flex: 2,
                child: CustomTimeButton(
                  onTap: () async {
                    String _hour = '${DateFormat('H').format(work.startedAt)}';
                    String _minute =
                        '${DateFormat('m').format(work.startedAt)}';
                    TimeOfDay _selected = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                        hour: int.parse(_hour),
                        minute: int.parse(_minute),
                      ),
                    );
                    if (_selected != null) {
                      String _date =
                          '${DateFormat('yyyy-MM-dd').format(work.startedAt)}';
                      String _time =
                          '${_selected.format(context).padLeft(5, '0')}:00.000';
                      DateTime _dateTime = DateTime.parse('$_date $_time');
                      setState(() => work.startedAt = _dateTime);
                    }
                  },
                  label: '${DateFormat('HH:mm').format(work.startedAt)}',
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
                    BreaksModel _breaks = work?.breaks[index];
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
                                    String _date =
                                        '${DateFormat('yyyy-MM-dd').format(_selected)}';
                                    String _time =
                                        '${DateFormat('HH:mm').format(_breaks.startedAt)}';
                                    DateTime _dateTime =
                                        DateTime.parse('$_date $_time');
                                    setState(
                                        () => _breaks.startedAt = _dateTime);
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
                                  String _hour =
                                      '${DateFormat('H').format(_breaks.startedAt)}';
                                  String _minute =
                                      '${DateFormat('m').format(_breaks.startedAt)}';
                                  TimeOfDay _selected = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(
                                      hour: int.parse(_hour),
                                      minute: int.parse(_minute),
                                    ),
                                  );
                                  if (_selected != null) {
                                    String _date =
                                        '${DateFormat('yyyy-MM-dd').format(_breaks.startedAt)}';
                                    String _time =
                                        '${_selected.format(context).padLeft(5, '0')}:00.000';
                                    DateTime _dateTime =
                                        DateTime.parse('$_date $_time');
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
                                    String _date =
                                        '${DateFormat('yyyy-MM-dd').format(_selected)}';
                                    String _time =
                                        '${DateFormat('HH:mm').format(_breaks.endedAt)}:00.000';
                                    DateTime _dateTime =
                                        DateTime.parse('$_date $_time');
                                    setState(() => _breaks.endedAt = _dateTime);
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
                                  String _hour =
                                      '${DateFormat('H').format(_breaks.endedAt)}';
                                  String _minute =
                                      '${DateFormat('m').format(_breaks.endedAt)}';
                                  TimeOfDay _selected = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(
                                      hour: int.parse(_hour),
                                      minute: int.parse(_minute),
                                    ),
                                  );
                                  if (_selected != null) {
                                    String _date =
                                        '${DateFormat('yyyy-MM-dd').format(_breaks.endedAt)}';
                                    String _time =
                                        '${_selected.format(context).padLeft(5, '0')}:00.000';
                                    DateTime _dateTime =
                                        DateTime.parse('$_date $_time');
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
                      initialDate: work.endedAt,
                      firstDate: kDayFirstDate,
                      lastDate: kDayLastDate,
                    );
                    if (_selected != null) {
                      String _date =
                          '${DateFormat('yyyy-MM-dd').format(_selected)}';
                      String _time =
                          '${DateFormat('HH:mm').format(work.endedAt)}:00.000';
                      DateTime _dateTime = DateTime.parse('$_date $_time');
                      setState(() => work.endedAt = _dateTime);
                    }
                  },
                  label: '${DateFormat('yyyy/MM/dd').format(work.endedAt)}',
                ),
              ),
              SizedBox(width: 4.0),
              Expanded(
                flex: 2,
                child: CustomTimeButton(
                  onTap: () async {
                    String _hour = '${DateFormat('H').format(work.endedAt)}';
                    String _minute = '${DateFormat('m').format(work.endedAt)}';
                    TimeOfDay _selected = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                        hour: int.parse(_hour),
                        minute: int.parse(_minute),
                      ),
                    );
                    if (_selected != null) {
                      String _date =
                          '${DateFormat('yyyy-MM-dd').format(work.endedAt)}';
                      String _time =
                          '${_selected.format(context).padLeft(5, '0')}:00.000';
                      DateTime _dateTime = DateTime.parse('$_date $_time');
                      setState(() => work.endedAt = _dateTime);
                    }
                  },
                  label: '${DateFormat('HH:mm').format(work.endedAt)}',
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
                work: work,
                user: widget.user,
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
