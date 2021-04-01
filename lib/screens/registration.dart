import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hatarakujikan_app/helpers/navigation.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/screens/home.dart';
import 'package:hatarakujikan_app/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_app/widgets/round_border_button.dart';
import 'package:hatarakujikan_app/widgets/spin_kit.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: double.infinity,
            child: userProvider.status == Status.Authenticating
                ? SpinKitWidget(size: 32.0)
                : SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('はたらくじかん', style: kTitleTextStyle),
                            Text('for スマートフォン', style: kSubTitleTextStyle),
                          ],
                        ),
                        SizedBox(height: 24.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextFormField(
                              controller: userProvider.name,
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
                              controller: userProvider.email,
                              obscureText: false,
                              textInputType: TextInputType.emailAddress,
                              maxLines: 1,
                              labelText: 'メールアドレス',
                              prefixIconData: Icons.email_outlined,
                              suffixIconData: null,
                              onTap: null,
                            ),
                            SizedBox(height: 16.0),
                            CustomTextFormField(
                              controller: userProvider.password,
                              obscureText: userProvider.isHidden ? false : true,
                              textInputType: null,
                              maxLines: 1,
                              labelText: 'パスワード',
                              prefixIconData: Icons.lock_outline,
                              suffixIconData: userProvider.isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              onTap: () => userProvider.changeHidden(),
                            ),
                            SizedBox(height: 16.0),
                            CustomTextFormField(
                              controller: userProvider.rePassword,
                              obscureText:
                                  userProvider.isReHidden ? false : true,
                              textInputType: null,
                              maxLines: 1,
                              labelText: 'パスワードの再入力',
                              prefixIconData: Icons.lock_outline,
                              suffixIconData: userProvider.isReHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              onTap: () => userProvider.changeReHidden(),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.0),
                        RoundBorderButton(
                          labelText: '登録',
                          labelColor: Colors.blue,
                          borderColor: Colors.blue,
                          labelFontSize: 16.0,
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          onPressed: () async {
                            if (!await userProvider.signUp()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('登録に失敗しました')),
                              );
                              return;
                            }
                            userProvider.clearController();
                            changeScreen(context, HomeScreen());
                          },
                        ),
                        SizedBox(height: 32.0),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              userProvider.clearController();
                              Navigator.pop(context);
                            },
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
