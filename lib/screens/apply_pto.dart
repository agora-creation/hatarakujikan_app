import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/models/group.dart';
import 'package:hatarakujikan_app/models/user.dart';
import 'package:hatarakujikan_app/providers/apply_pto.dart';
import 'package:hatarakujikan_app/widgets/custom_date_button.dart';
import 'package:hatarakujikan_app/widgets/custom_icon_label.dart';
import 'package:hatarakujikan_app/widgets/custom_list_tile.dart';
import 'package:hatarakujikan_app/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_app/widgets/error_dialog.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';
import 'package:provider/provider.dart';

class ApplyPTOScreen extends StatefulWidget {
  final GroupModel? group;
  final UserModel? user;

  ApplyPTOScreen({
    this.group,
    this.user,
  });

  @override
  State<ApplyPTOScreen> createState() => _ApplyPTOScreenState();
}

class _ApplyPTOScreenState extends State<ApplyPTOScreen> {
  DateTime startedAt = DateTime.now();
  DateTime endedAt = DateTime.now().add(Duration(hours: 8));
  TextEditingController reason = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final applyPTOProvider = Provider.of<ApplyPTOProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal.shade100,
        elevation: 0.0,
        centerTitle: true,
        title: Text('有給休暇の申請', style: TextStyle(color: Colors.black54)),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: 32.0, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          Text('取得したい日時に入力し、最後に「申請する」ボタンを押してください。'),
          SizedBox(height: 16.0),
          CustomListTile(
            label: '会社/組織名',
            value: widget.group?.name,
          ),
          CustomListTile(
            label: '申請者名',
            value: widget.user?.name,
          ),
          SizedBox(height: 16.0),
          CustomIconLabel(
            icon: Icon(Icons.arrow_right, color: Colors.grey),
            label: '開始日',
          ),
          SizedBox(height: 4.0),
          CustomDateButton(
            label: dateText('yyyy/MM/dd', startedAt),
            onTap: () async {
              DateTime? _date = await customDatePicker(
                context: context,
                init: startedAt,
              );
              if (_date == null) return;
              DateTime _dateTime = rebuildDate(_date, startedAt);
              setState(() => startedAt = _dateTime);
            },
          ),
          SizedBox(height: 8.0),
          CustomIconLabel(
            icon: Icon(Icons.arrow_right, color: Colors.grey),
            label: '終了日',
          ),
          SizedBox(height: 4.0),
          CustomDateButton(
            label: dateText('yyyy/MM/dd', endedAt),
            onTap: () async {
              DateTime? _date = await customDatePicker(
                context: context,
                init: endedAt,
              );
              if (_date == null) return;
              DateTime _dateTime = rebuildDate(_date, endedAt);
              setState(() => endedAt = _dateTime);
            },
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
          ),
          SizedBox(height: 16.0),
          RoundBackgroundButton(
            label: '申請する',
            color: Colors.white,
            backgroundColor: Colors.blue,
            onPressed: () async {
              if (!await applyPTOProvider.create(
                group: widget.group,
                user: widget.user,
                startedAt: startedAt,
                endedAt: endedAt,
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
