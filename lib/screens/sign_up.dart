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
                ScreenSetting.buildFirstNameField(),
                Field.separate(),
                ScreenSetting.buildLastNameField(),
                Field.separate(),
                ScreenSetting.buildPhoneField(),
                Field.separate(),
                ScreenSetting.buildEmailField(),
                Field.separate(),
                ScreenSetting.buildPasswordField(),
                Field.separate(),
                ScreenSetting.buildPasswordConfirmField(),
                Field.separate(),
                ScreenSetting.buildSubmitButton('SIGN UP'),
              ],
            ),
          )
        ],
      )
    );
  }
}
