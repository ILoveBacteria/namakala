import 'package:flutter/material.dart';
import 'package:namakala/screens/sign_in.dart';
import 'package:namakala/widgets/button.dart';
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
      appBar: ScreenSetting.appBar(title: 'Sign Up'),
      context: context,
      child: Column(
        children: [
          Field.parentContainer(
            child: Column(
              children: [
                Field.firstName(),
                Field.separate(),
                Field.lastName(),
                Field.separate(),
                Field.phone(),
                Field.separate(),
                Field.email(),
                Field.separate(),
                Field.password(),
                Field.separate(),
                Field.passwordConfirm(),
                Button.separate(),
                Button.signUp(onPress: () {}),
                Field.separate(),
                ScreenSetting.buildDetailTextAndButton(
                  text: 'Already have an account?',
                  buttonText: 'SIGN IN',
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const SignIn()),
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
