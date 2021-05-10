import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/screens/group_select.dart';
import 'package:hatarakujikan_app/widgets/custom_expanded_button.dart';

class ApplyScreen extends StatefulWidget {
  final UserProvider userProvider;

  ApplyScreen({@required this.userProvider});

  @override
  _ApplyScreenState createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.userProvider.group != null
        ? Column(
            children: [
              CustomExpandedButton(
                buttonColor: Colors.blueGrey,
                labelText: widget.userProvider.group?.name,
                labelColor: Colors.white,
                leadingIcon: Icon(Icons.store, color: Colors.white),
                trailingIcon: Icon(Icons.arrow_drop_down, color: Colors.white),
                onTap: () => overlayScreen(
                  context,
                  GroupSelect(userProvider: widget.userProvider),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text('申請はありませんでした'),
                ),
              ),
            ],
          )
        : Center(child: Text('会社/組織に所属していません'));
  }
}
