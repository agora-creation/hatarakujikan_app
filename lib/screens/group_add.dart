import 'package:flutter/material.dart';
import 'package:hatarakujikan_app/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';

class GroupAddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        elevation: 0.0,
        centerTitle: true,
        title: Text('会社/組織を作る', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        children: [
          SizedBox(height: 16.0),
          CustomTextFormField(
            controller: null,
            obscureText: false,
            textInputType: TextInputType.name,
            maxLines: 1,
            labelText: '会社/組織名',
            prefixIconData: Icons.store,
            suffixIconData: null,
            onTap: null,
          ),
          SizedBox(height: 24.0),
          RoundBackgroundButton(
            labelText: '作成する',
            labelColor: Colors.white,
            backgroundColor: Colors.blue,
            labelFontSize: 16.0,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
