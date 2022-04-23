import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/dialogs.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/apply_work.dart';
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
import 'package:provider/provider.dart';

class ApplyWorkScreen extends StatefulWidget {
  final WorkModel work;
  final UserModel user;

  ApplyWorkScreen({
    required this.work,
    required this.user,
  });

  @override
  _ApplyWorkScreenState createState() => _ApplyWorkScreenState();
}

class _ApplyWorkScreenState extends State<ApplyWorkScreen> {
  ApplyWorkModel? applyWork;
  List<BreaksModel> breaks = [];
  TextEditingController reason = TextEditingController();

  void _init() async {
    await versionCheck().then((value) {
      if (!value) return;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => UpdaterDialog(),
      );
    });
    if (mounted) {
      setState(() {
        applyWork = ApplyWorkModel.set({
          'workId': widget.work.id,
          'groupId': widget.work.groupId,
          'userId': widget.work.userId,
          'userName': '',
          'startedAt': widget.work.startedAt,
          'endedAt': widget.work.endedAt,
        });
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
        backgroundColor: Colors.blue.shade100,
        elevation: 0.0,
        centerTitle: true,
        title: Text('記録修正申請', style: TextStyle(color: Colors.black54)),
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
          Row(
            children: [
              Expanded(
                flex: 3,
                child: CustomDateButton(
                  onTap: () async {
                    DateTime? _date = await customDatePicker(
                      context: context,
                      init: applyWork?.startedAt ?? DateTime.now(),
                    );
                    if (_date == null) return;
                    DateTime _dateTime = rebuildDate(
                      _date,
                      applyWork?.startedAt,
                    );
                    setState(() => applyWork?.startedAt = _dateTime);
                  },
                  label: dateText('yyyy/MM/dd', applyWork?.startedAt),
                ),
              ),
              SizedBox(width: 4.0),
              Expanded(
                flex: 2,
                child: CustomTimeButton(
                  onTap: () async {
                    String? _time = await customTimePicker(
                      context: context,
                      init: dateText('HH:mm', applyWork?.startedAt),
                    );
                    if (_time == null) return;
                    DateTime _dateTime = rebuildTime(
                      context,
                      applyWork?.startedAt,
                      _time,
                    );
                    setState(() => applyWork?.startedAt = _dateTime);
                  },
                  label: dateText('HH:mm', applyWork?.startedAt),
                ),
              ),
            ],
          ),
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
                    DateTime? _date = await customDatePicker(
                      context: context,
                      init: applyWork?.endedAt ?? DateTime.now(),
                    );
                    if (_date == null) return;
                    DateTime _dateTime = rebuildDate(
                      _date,
                      applyWork?.endedAt,
                    );
                    setState(() => applyWork?.endedAt = _dateTime);
                  },
                  label: dateText('yyyy/MM/dd', applyWork?.endedAt),
                ),
              ),
              SizedBox(width: 4.0),
              Expanded(
                flex: 2,
                child: CustomTimeButton(
                  onTap: () async {
                    String? _time = await customTimePicker(
                      context: context,
                      init: dateText('HH:mm', applyWork?.endedAt),
                    );
                    if (_time == null) return;
                    DateTime _dateTime = rebuildTime(
                      context,
                      applyWork?.endedAt,
                      _time,
                    );
                    setState(() => applyWork?.endedAt = _dateTime);
                  },
                  label: dateText('HH:mm', applyWork?.endedAt),
                ),
              ),
            ],
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
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: CustomDateButton(
                                onTap: () async {
                                  DateTime? _date = await customDatePicker(
                                    context: context,
                                    init: _breaks.startedAt,
                                  );
                                  if (_date == null) return;
                                  DateTime _dateTime = rebuildDate(
                                    _date,
                                    _breaks.startedAt,
                                  );
                                  setState(() => _breaks.startedAt = _dateTime);
                                },
                                label: dateText(
                                  'yyyy/MM/dd',
                                  _breaks.startedAt,
                                ),
                              ),
                            ),
                            SizedBox(width: 4.0),
                            Expanded(
                              flex: 2,
                              child: CustomTimeButton(
                                onTap: () async {
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
                                label: dateText('HH:mm', _breaks.startedAt),
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
                                label: dateText('yyyy/MM/dd', _breaks.endedAt),
                              ),
                            ),
                            SizedBox(width: 4.0),
                            Expanded(
                              flex: 2,
                              child: CustomTimeButton(
                                onTap: () async {
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
                                label: dateText('HH:mm', _breaks.endedAt),
                              ),
                            ),
                          ],
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
            suffix: null,
            onTap: null,
          ),
          SizedBox(height: 16.0),
          RoundBackgroundButton(
            onPressed: () async {
              applyWork?.breaks = breaks;
              applyWork?.reason = reason.text.trim();
              if (!await applyWorkProvider.create(applyWork: applyWork)) {
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
        ],
      ),
    );
  }
}
