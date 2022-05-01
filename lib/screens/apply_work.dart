import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/breaks.dart';
import 'package:hatarakujikan_app/models/work.dart';
import 'package:hatarakujikan_app/providers/apply_work.dart';
import 'package:hatarakujikan_app/screens/datetime_form_field.dart';
import 'package:hatarakujikan_app/widgets/custom_icon_label.dart';
import 'package:hatarakujikan_app/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_app/widgets/error_dialog.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';
import 'package:provider/provider.dart';

class ApplyWorkScreen extends StatefulWidget {
  final WorkModel work;

  ApplyWorkScreen({required this.work});

  @override
  _ApplyWorkScreenState createState() => _ApplyWorkScreenState();
}

class _ApplyWorkScreenState extends State<ApplyWorkScreen> {
  WorkModel? work;
  List<BreaksModel> breaks = [];
  TextEditingController reason = TextEditingController();

  void _init() async {
    if (mounted) {
      setState(() {
        work = widget.work;
        breaks = widget.work.breaks;
      });
    }
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
        backgroundColor: Colors.lightBlue.shade100,
        elevation: 0.0,
        centerTitle: true,
        title: Text('勤怠修正の申請', style: TextStyle(color: Colors.black54)),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.black54),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
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
          DateTimeFormField(
            date: dateText('yyyy/MM/dd', work?.startedAt),
            dateOnTap: () async {
              DateTime? _date = await customDatePicker(
                context: context,
                init: work?.startedAt ?? DateTime.now(),
              );
              if (_date == null) return;
              DateTime _dateTime = rebuildDate(
                _date,
                work?.startedAt,
              );
              setState(() => work?.startedAt = _dateTime);
            },
            time: dateText('HH:mm', work?.startedAt),
            timeOnTap: () async {
              String? _time = await customTimePicker(
                context: context,
                init: dateText('HH:mm', work?.startedAt),
              );
              if (_time == null) return;
              DateTime _dateTime = rebuildTime(
                context,
                work?.startedAt,
                _time,
              );
              setState(() => work?.startedAt = _dateTime);
            },
          ),
          SizedBox(height: 8.0),
          CustomIconLabel(
            icon: Icon(Icons.run_circle, color: Colors.red),
            label: '退勤日時',
          ),
          SizedBox(height: 4.0),
          DateTimeFormField(
            date: dateText('yyyy/MM/dd', work?.endedAt),
            dateOnTap: () async {
              DateTime? _date = await customDatePicker(
                context: context,
                init: work?.endedAt ?? DateTime.now(),
              );
              if (_date == null) return;
              DateTime _dateTime = rebuildDate(
                _date,
                work?.endedAt,
              );
              setState(() => work?.endedAt = _dateTime);
            },
            time: dateText('HH:mm', work?.endedAt),
            timeOnTap: () async {
              String? _time = await customTimePicker(
                context: context,
                init: dateText('HH:mm', work?.endedAt),
              );
              if (_time == null) return;
              DateTime _dateTime = rebuildTime(
                context,
                work?.endedAt,
                _time,
              );
              setState(() => work?.endedAt = _dateTime);
            },
          ),
          SizedBox(height: 8.0),
          breaks.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: breaks.length,
                  itemBuilder: (_, index) {
                    BreaksModel _breaks = breaks[index];
                    return Column(
                      children: [
                        CustomIconLabel(
                          icon: Icon(Icons.run_circle, color: Colors.orange),
                          label: '休憩開始日時',
                        ),
                        SizedBox(height: 4.0),
                        DateTimeFormField(
                          date: dateText('yyyy/MM/dd', _breaks.startedAt),
                          dateOnTap: () async {
                            DateTime? _date = await customDatePicker(
                              context: context,
                              init: _breaks.startedAt,
                            );
                            if (_date == null) return;
                            DateTime _dateTime =
                                rebuildDate(_date, _breaks.startedAt);
                            setState(() => _breaks.startedAt = _dateTime);
                          },
                          time: dateText('HH:mm', _breaks.startedAt),
                          timeOnTap: () async {
                            String? _time = await customTimePicker(
                              context: context,
                              init: dateText('HH:mm', _breaks.startedAt),
                            );
                            if (_time == null) return;
                            DateTime _dateTime = rebuildTime(
                              context,
                              _breaks.startedAt,
                              _time,
                            );
                            setState(() => _breaks.startedAt = _dateTime);
                          },
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
                        DateTimeFormField(
                          date: dateText('yyyy/MM/dd', _breaks.endedAt),
                          dateOnTap: () async {
                            DateTime? _date = await customDatePicker(
                              context: context,
                              init: _breaks.endedAt,
                            );
                            if (_date == null) return;
                            DateTime _dateTime = rebuildDate(
                              _date,
                              _breaks.endedAt,
                            );
                            setState(() => _breaks.endedAt = _dateTime);
                          },
                          time: dateText('HH:mm', _breaks.endedAt),
                          timeOnTap: () async {
                            String? _time = await customTimePicker(
                              context: context,
                              init: dateText('HH:mm', _breaks.endedAt),
                            );
                            if (_time == null) return;
                            DateTime _dateTime = rebuildTime(
                              context,
                              _breaks.endedAt,
                              _time,
                            );
                            setState(() => _breaks.endedAt = _dateTime);
                          },
                        ),
                      ],
                    );
                  },
                )
              : Container(),
          SizedBox(height: 16.0),
          CustomTextFormField(
            controller: reason,
            obscureText: false,
            textInputType: TextInputType.multiline,
            maxLines: null,
            label: '事由',
            color: Colors.black54,
            prefix: Icons.short_text,
          ),
          SizedBox(height: 16.0),
          RoundBackgroundButton(
            label: '申請する',
            color: Colors.white,
            backgroundColor: Colors.blue,
            onPressed: () async {
              if (!await applyWorkProvider.create(
                work: work,
                breaks: breaks,
                reason: reason.text.toString(),
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
          ),
        ],
      ),
    );
  }
}
