import 'package:flutter/material.dart';
import 'package:namakala/data/user_data.dart';
import 'package:namakala/screens/sign_up.dart';
import 'package:namakala/socket/command.dart';
import 'package:namakala/socket/socket.dart';
import 'package:namakala/widgets/button.dart';
import 'package:namakala/widgets/field.dart';
import 'package:namakala/widgets/screen_setting.dart';

import 'main_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  VoidCallback? _submitButton;
  bool _obscurePassword = true;
  late Field phoneField;
  late Field passwordField;

  @override
  void initState() {
    super.initState();
    phoneField = Field.phone(
      setState: setState,
      changeEnablingSubmitButton: _changeButtonEnabled,
    );

    passwordField = Field.password(
      setState: setState,
      obscureText: _obscurePassword,
      changeEnablingSubmitButton: _changeButtonEnabled,
      suffixButton: IconButton(
        icon: _obscurePassword
            ? const Icon(Icons.visibility_off_outlined)
            : const Icon(Icons.visibility_outlined),
        color: Colors.grey,
        onPressed: () {
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        },
      ),
    );
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
                phoneField.build(),
                Field.separate(),
                passwordField.build(),
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
      phoneField.controller.text.isNotEmpty && passwordField.controller.text.isNotEmpty
          ? _submitButton = () => _onSignInButtonPressed()
          : _submitButton = null;
    });
  }

  void _onSignInButtonPressed() async {
    phoneField.focusNode.unfocus();
    passwordField.focusNode.unfocus();
    setState(() {});

    if (await _signInUser()) {
      UserData.phone =  phoneField.controller.text;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MainScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  Future<bool> _signInUser() async {
    MySocket socket = MySocket(null, Command.signIn,
        [phoneField.controller.text, passwordField.controller.text]);
    String response = await socket.sendAndReceive();
    return _checkServerResponse(response);
  }

  bool _checkServerResponse(String value) {
    List<String> list = value.split(';');
    bool phoneValid = list.elementAt(0) == 'true' ? true : false;
    bool passValid = list.elementAt(1) == 'true' ? true : false;

    _validateAllFields(phoneValid, passValid);
    setState(() {});
    return phoneValid && passValid;
  }

  void _validateAllFields(bool phoneValid, bool passValid) {
    if (phoneValid) {
      phoneField.status = FieldStatus.validate;
    } else {
      phoneField.status = FieldStatus.error;
    }

    if (passValid) {
      phoneField.status = FieldStatus.validate;
    } else {
      passwordField.status = FieldStatus.error;
    }
  }
}
