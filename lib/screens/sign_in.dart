import 'package:flutter/material.dart';
import 'package:namakala/widgets/field.dart';
import 'package:namakala/widgets/screen_setting.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return ScreenSetting.initSignInAndUp(
      context: context,
      child: Column(
        children: [
          ScreenSetting.buildTitleText('Sign In'),
          const SizedBox(height: 50.0),
          ScreenSetting.fieldsContainer(
            child: Column(
              children: [
                ScreenSetting.buildEmailField(),
                Field.separate(),
                ScreenSetting.buildPasswordField(),
                Field.separate(),
                ScreenSetting.buildSubmitButton('SIGN IN'),
              ],
            ),
          )
        ],
      )
    );
  }
}
