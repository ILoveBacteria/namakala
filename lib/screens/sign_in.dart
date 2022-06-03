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
  final _phoneFocus = FocusNode();
  final _passwordFocus = FocusNode();
  FieldStatus _phoneStatus = FieldStatus.none;
  FieldStatus _passwordStatus = FieldStatus.none;
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  VoidCallback? _submitButton;

  @override
  void dispose() {
    super.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenSetting.initSignInAndUp(
      appBar: ScreenSetting.appBar(title: 'Sign In'),
      context: context,
      child: Column(
        children: <Widget>[
          Field.parentContainer(
            child: Column(
              children: <Widget>[
                Field.phone(
                  focusNode: _phoneFocus,
                  status: _phoneStatus,
                  controller: _phoneController,
                  onTap: () => setState(() {}),
                  onEditingComplete: () {
                    setState(() {
                      Field.phoneValidate(_phoneController.text)
                          ? _phoneStatus = FieldStatus.validate
                          : _phoneStatus = FieldStatus.error;

                      _phoneFocus.unfocus();
                    });
                  },
                  onChanged: (_) {
                    setState(() {
                      _phoneStatus = FieldStatus.none;
                      _changeButtonEnabled();
                    });
                  },
                ),
                Field.separate(),
                Field.password(
                  focusNode: _passwordFocus,
                  status: _passwordStatus,
                  controller: _passwordController,
                  onTap: () => setState(() {}),
                  onEditingComplete: () {
                    setState(() {
                      Field.passwordValidate(_passwordController.text)
                          ? _passwordStatus = FieldStatus.validate
                          : _passwordStatus = FieldStatus.error;

                      _passwordFocus.unfocus();
                    });
                  },
                  onChanged: (_) {
                    setState(() {
                      _passwordStatus = FieldStatus.none;
                      _changeButtonEnabled();
                    });
                  },
                ),
                Button.separate(),
                Button.signIn(onPressed: _submitButton),
                Field.separate(),
                ScreenSetting.buildDetailTextAndButton(
                  text: 'Don\'t have an account?',
                  buttonText: 'SIGN UP',
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const SignUp()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _changeButtonEnabled() {
    setState(() {
      _phoneController.text.isNotEmpty && _passwordController.text.isNotEmpty
          ? _submitButton = () {}
          : _submitButton = null;
    });
  }
}
