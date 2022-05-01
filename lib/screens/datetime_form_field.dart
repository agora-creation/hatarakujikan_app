import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/widgets/custom_date_button.dart';
import 'package:hatarakujikan_app/widgets/custom_time_button.dart';

class DateTimeFormField extends StatelessWidget {
  final String? date;
  final Function()? dateOnTap;
  final String? time;
  final Function()? timeOnTap;

  DateTimeFormField({
    this.date,
    this.dateOnTap,
    this.time,
    this.timeOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: CustomDateButton(
            label: date,
            onTap: dateOnTap,
          ),
        ),
        SizedBox(width: 4.0),
        Expanded(
          flex: 2,
          child: CustomTimeButton(
            label: time,
            onTap: timeOnTap,
          ),
        ),
      ],
    );
  }
}
