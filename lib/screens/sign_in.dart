import 'package:flutter/material.dart';
import 'package:namakala/screens/sign_up.dart';
import 'package:namakala/widgets/button.dart';
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
      appBar: ScreenSetting.appBar(title: 'Sign In'),
      context: context,
      child: Column(
        children: [
          Field.parentContainer(
            child: Column(
              children: [
                Field.email(),
                Field.separate(),
                Field.password(),
                Button.separate(),
                Button.signIn(onPressed: () {}),
                Field.separate(),
                ScreenSetting.buildDetailTextAndButton(
                  text: 'Don\'t have an account?',
                  buttonText: 'SIGN UP',
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const SignUp()),
                      (Route<dynamic> route) => false,
                    );
                  }
                )
              ],
            ),
          )
        ],
      )
    );
  }
}
