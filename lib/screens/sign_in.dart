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
  final _phoneFocus = FocusNode();
  final _passwordFocus = FocusNode();
  FieldStatus _phoneStatus = FieldStatus.none;
  FieldStatus _passwordStatus = FieldStatus.none;
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  VoidCallback? _submitButton;
  bool _obscurePassword = true;

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
                  onChanged: (_) {
                    setState(() {
                      _phoneStatus = FieldStatus.none;
                      _changeButtonEnabled();
                    });
                  },
                ),
                Field.separate(),
                Field.password(
                  obscureText: _obscurePassword,
                  focusNode: _passwordFocus,
                  status: _passwordStatus,
                  controller: _passwordController,
                  onTap: () => setState(() {}),
                  onChanged: (_) {
                    setState(() {
                      _passwordStatus = FieldStatus.none;
                      _changeButtonEnabled();
                    });
                  },
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
          ? _submitButton = () => _onSignInButtonPressed()
          : _submitButton = null;
    });
  }

  void _onSignInButtonPressed() async {
    _phoneFocus.unfocus();
    _passwordFocus.unfocus();
    setState(() {});

    if (await _signInUser()) {
      UserData.phone = _phoneController.text;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MainScreen()),
            (Route<dynamic> route) => false,
      );
    }
  }

  Future<bool> _signInUser() async {
    MySocket socket = MySocket(null, Command.signIn, [_phoneController.text, _passwordController.text]);
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
      _phoneStatus = FieldStatus.validate;
    } else {
      _phoneStatus = FieldStatus.error;
    }

    if (passValid) {
      _phoneStatus = FieldStatus.validate;
    } else {
      _passwordStatus = FieldStatus.error;
    }
  }
}
