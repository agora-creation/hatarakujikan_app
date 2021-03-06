import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hatarakujikan_app/screens/home.dart';
import 'package:hatarakujikan_app/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_app/widgets/round_border_button.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('はたらくじかん', style: TextStyle(fontSize: 32.0)),
                      Text('for スマートフォン', style: TextStyle(fontSize: 16.0)),
                    ],
                  ),
                  SizedBox(height: 24.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                        controller: null,
                        obscureText: false,
                        textInputType: TextInputType.name,
                        maxLines: 1,
                        labelText: 'お名前',
                        prefixIconData: Icons.person_outline,
                        suffixIconData: null,
                        onTap: null,
                      ),
                      SizedBox(height: 16.0),
                      CustomTextFormField(
                        controller: null,
                        obscureText: false,
                        textInputType: TextInputType.emailAddress,
                        maxLines: 1,
                        labelText: 'メールアドレス',
                        prefixIconData: Icons.mail_outline,
                        suffixIconData: null,
                        onTap: null,
                      ),
                      SizedBox(height: 16.0),
                      CustomTextFormField(
                        controller: null,
                        obscureText: true,
                        textInputType: null,
                        maxLines: 1,
                        labelText: 'パスワード',
                        prefixIconData: Icons.lock_outline,
                        suffixIconData: Icons.visibility_off,
                        onTap: null,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.0),
                  RoundBorderButton(
                    labelText: '登録',
                    labelColor: Colors.blueAccent,
                    borderColor: Colors.blueAccent,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 32.0),
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        '登録済みの方はココをタップ',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
