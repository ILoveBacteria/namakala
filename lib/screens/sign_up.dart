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
  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _passwordConfirmFocus = FocusNode();
  FieldStatus _firstNameStatus = FieldStatus.none;
  FieldStatus _lastNameStatus = FieldStatus.none;
  FieldStatus _phoneStatus = FieldStatus.none;
  FieldStatus _emailStatus = FieldStatus.none;
  FieldStatus _passwordStatus = FieldStatus.none;
  FieldStatus _passwordConfirmStatus = FieldStatus.none;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _phoneFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _passwordConfirmFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenSetting.initSignInAndUp(
      appBar: ScreenSetting.appBar(title: 'Sign Up'),
      context: context,
      child: Column(
        children: <Widget>[
          Field.parentContainer(
            child: Column(
              children: [
                Field.firstName(
                  focusNode: _firstNameFocus,
                  status: _firstNameStatus,
                  controller: _firstNameController,
                  onTap: () => setState(() {}),
                  onEditingComplete: () {
                    setState(() {
                      Field.nameValidate(_firstNameController.text)
                          ? _firstNameStatus = FieldStatus.validate
                          : _firstNameStatus = FieldStatus.error;

                      _firstNameFocus.unfocus();
                    });
                  },
                  onChanged: (_) => setState(() => _firstNameStatus = FieldStatus.none),
                ),
                Field.separate(),
                Field.lastName(
                  focusNode: _lastNameFocus,
                  status: _lastNameStatus,
                  controller: _lastNameController,
                  onTap: () => setState(() {}),
                  onEditingComplete: () {
                    setState(() {
                      Field.nameValidate(_lastNameController.text)
                          ? _lastNameStatus = FieldStatus.validate
                          : _lastNameStatus = FieldStatus.error;

                      _lastNameFocus.unfocus();
                    });
                  },
                  onChanged: (_) => setState(() => _lastNameStatus = FieldStatus.none),
                ),
                Field.separate(),
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
                  onChanged: (_) => setState(() => _phoneStatus = FieldStatus.none),
                ),
                Field.separate(),
                Field.email(
                  focusNode: _emailFocus,
                  status: _emailStatus,
                  controller: _emailController,
                  onTap: () => setState(() {}),
                  onEditingComplete: () {
                    setState(() {
                      Field.emailValidate(_emailController.text)
                          ? _emailStatus = FieldStatus.validate
                          : _emailStatus = FieldStatus.error;

                      _emailFocus.unfocus();
                    });
                  },
                  onChanged: (_) => setState(() => _emailStatus = FieldStatus.none),
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
                  onChanged: (_) => setState(() => _passwordStatus = FieldStatus.none),
                ),
                Field.separate(),
                Field.passwordConfirm(
                  focusNode: _passwordConfirmFocus,
                  status: _passwordConfirmStatus,
                  controller: _passwordConfirmController,
                  onTap: () => setState(() {}),
                  onEditingComplete: () {
                    setState(() {
                      _passwordConfirmController.text == _passwordController.text
                          ? _passwordConfirmStatus = FieldStatus.validate
                          : _passwordConfirmStatus = FieldStatus.error;

                      _passwordConfirmFocus.unfocus();
                    });
                  },
                  onChanged: (_) => setState(() => _passwordConfirmStatus = FieldStatus.none),
                ),
                Button.separate(),
                Button.signUp(onPressed: () {}),
                Field.separate(),
                ScreenSetting.buildDetailTextAndButton(
                  text: 'Already have an account?',
                  buttonText: 'SIGN IN',
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const SignIn()),
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
}
