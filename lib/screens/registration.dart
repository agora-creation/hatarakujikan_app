import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hatarakujikan_app/helpers/functions.dart';
import 'package:hatarakujikan_app/helpers/style.dart';
import 'package:hatarakujikan_app/providers/user.dart';
import 'package:hatarakujikan_app/screens/home.dart';
import 'package:hatarakujikan_app/screens/login.dart';
import 'package:hatarakujikan_app/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_app/widgets/error_message.dart';
import 'package:hatarakujikan_app/widgets/loading.dart';
import 'package:hatarakujikan_app/widgets/round_background_button.dart';
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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF4DD0E1),
                  Color(0xFF00BCD4),
                ],
              ),
            ),
            child: userProvider.status == Status.Authenticating
                ? Loading(size: 32.0, color: Colors.white)
                : SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 100.0,
                            height: 100.0,
                          ),
                        ),
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
                              labelColor: Colors.white,
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
                              labelColor: Colors.white,
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
                              labelColor: Colors.white,
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
                              labelColor: Colors.white,
                              prefixIconData: Icons.lock_outline,
                              suffixIconData: userProvider.isReHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              onTap: () => userProvider.changeReHidden(),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.0),
                        RoundBackgroundButton(
                          labelText: '登録',
                          labelColor: Colors.blue,
                          backgroundColor: Colors.white,
                          onPressed: () async {
                            if (!await userProvider.signUp()) {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (_) => ErrorMessage(
                                  message: '登録に失敗しました。再度入力内容をご確認ください。',
                                ),
                              );
                              return;
                            }
                            userProvider.clearController();
                            userProvider.reloadUserModel();
                            changeScreen(context, HomeScreen());
                          },
                        ),
                        SizedBox(height: 32.0),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              userProvider.clearController();
                              nextScreen(context, LoginScreen());
                            },
                            child: Text(
                              '登録済みの方はログインから',
                              style: TextStyle(
                                color: Colors.white,
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
