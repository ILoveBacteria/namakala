import 'package:flutter/material.dart';
import 'package:namakala/widgets/screen_setting.dart';
import '../widgets/field.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return ScreenSetting.initSignInAndUp(
      context: context,
      child: Column(
        children: [
          ScreenSetting.buildTitleText('Sign Up'),
          const SizedBox(height: 50.0),
          ScreenSetting.fieldsContainer(
            child: Column(
              children: [
                ScreenSetting.buildEmailField(),
                Field.separate(),
                ScreenSetting.buildPasswordField(),
              ],
            ),
          )
        ],
      )
    );
  }
}
