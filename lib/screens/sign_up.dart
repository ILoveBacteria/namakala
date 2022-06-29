import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:namakala/data/user_data.dart';
import 'package:namakala/screens/main_screen.dart';
import 'package:namakala/screens/sign_in.dart';
import 'package:namakala/socket/command.dart';
import 'package:namakala/socket/socket.dart';
import 'package:namakala/utilities/market.dart';
import 'package:namakala/utilities/person.dart';
import 'package:namakala/widgets/button.dart';
import 'package:namakala/widgets/screen_setting.dart';
import '../widgets/field.dart';
import '../widgets/snack_message.dart';

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
  final _marketFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _passwordConfirmFocus = FocusNode();
  FieldStatus _firstNameStatus = FieldStatus.none;
  FieldStatus _lastNameStatus = FieldStatus.none;
  FieldStatus _phoneStatus = FieldStatus.none;
  FieldStatus _emailStatus = FieldStatus.none;
  FieldStatus _marketStatus = FieldStatus.none;
  FieldStatus _passwordStatus = FieldStatus.none;
  FieldStatus _passwordConfirmStatus = FieldStatus.none;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _marketController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  VoidCallback? _submitButton;
  bool _obscurePassword = true;
  bool _obscurePasswordConfirm = true;

  @override
  void dispose() {
    super.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _phoneFocus.dispose();
    _emailFocus.dispose();
    _marketFocus.dispose();
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
              children: <Widget>[
                Field.firstName(
                  focusNode: _firstNameFocus,
                  status: _firstNameStatus,
                  controller: _firstNameController,
                  onTap: () => setState(() {}),
                  onEditingComplete: () {
                    _firstNameValidate();
                    setState(() {});
                  },
                  onChanged: (_) {
                    setState(() {
                      _firstNameStatus = FieldStatus.none;
                      _changeButtonEnabled();
                    });
                  },
                ),
                Field.separate(),
                Field.lastName(
                  focusNode: _lastNameFocus,
                  status: _lastNameStatus,
                  controller: _lastNameController,
                  onTap: () => setState(() {}),
                  onEditingComplete: () {
                    _lastNameValidate();
                    setState(() {});
                  },
                  onChanged: (_) {
                    setState(() {
                      _lastNameStatus = FieldStatus.none;
                      _changeButtonEnabled();
                    });
                  },
                ),
                Field.separate(),
                Field.phone(
                  focusNode: _phoneFocus,
                  status: _phoneStatus,
                  controller: _phoneController,
                  onTap: () => setState(() {}),
                  onEditingComplete: () {
                    _phoneValidate();
                    setState(() {});
                  },
                  onChanged: (_) {
                    setState(() {
                      _phoneStatus = FieldStatus.none;
                      _changeButtonEnabled();
                    });
                  },
                ),
                Field.separate(),
                Field.email(
                  focusNode: _emailFocus,
                  status: _emailStatus,
                  controller: _emailController,
                  onTap: () => setState(() {}),
                  onEditingComplete: () {
                    _emailValidate();
                    setState(() {});
                  },
                  onChanged: (_) =>
                      setState(() => _emailStatus = FieldStatus.none),
                ),
                Field.separate(),
                Field.market(
                  focusNode: _marketFocus,
                  status: _marketStatus,
                  controller: _marketController,
                  onTap: () => setState(() {}),
                  onEditingComplete: () {
                    _marketValidate();
                    setState(() {});
                  },
                  onChanged: (_) => setState(() => _marketStatus = FieldStatus.none),
                ),
                Field.separate(),
                Field.password(
                  obscureText: _obscurePassword,
                  focusNode: _passwordFocus,
                  status: _passwordStatus,
                  controller: _passwordController,
                  onTap: () => setState(() {}),
                  onEditingComplete: () {
                    _passwordValidate();
                    setState(() {});
                  },
                  onChanged: (_) {
                    setState(() {
                      _passwordStatus = FieldStatus.none;
                      _changeButtonEnabled();
                    });
                  },
                  suffixButton: IconButton(
                    icon: _obscurePassword ? const Icon(Icons.visibility_off_outlined) : const Icon(Icons.visibility_outlined),
                    color: Colors.grey,
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                Field.separate(),
                Field.passwordConfirm(
                  obscureText: _obscurePasswordConfirm,
                  focusNode: _passwordConfirmFocus,
                  status: _passwordConfirmStatus,
                  controller: _passwordConfirmController,
                  onTap: () => setState(() {}),
                  onEditingComplete: () {
                    _passwordConfirmValidate();
                    setState(() {});
                  },
                  onChanged: (_) {
                    setState(() {
                      _passwordConfirmStatus = FieldStatus.none;
                      _changeButtonEnabled();
                    });
                  },
                  suffixButton: IconButton(
                    icon: _obscurePasswordConfirm ? const Icon(Icons.visibility_off_outlined) : const Icon(Icons.visibility_outlined),
                    color: Colors.grey,
                    onPressed: () {
                      setState(() {
                        _obscurePasswordConfirm = !_obscurePasswordConfirm;
                      });
                    },
                  ),
                ),
                Button.separate(),
                Button.signUp(onPressed: _submitButton),
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

  void _changeButtonEnabled() {
    setState(() {
      _firstNameController.text.isNotEmpty &&
              _lastNameController.text.isNotEmpty &&
              _phoneController.text.isNotEmpty &&
              _passwordController.text.isNotEmpty &&
              _passwordConfirmController.text.isNotEmpty
          ? _submitButton = () => _onSignUpButtonPressed()
          : _submitButton = null;
    });
  }

  void _onSignUpButtonPressed() async {
    _validateAllFields();
    setState(() {});

    if (_isValidateAllFields() && await _createNewUser()) {
      UserData.phone = _phoneController.text;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MainScreen()),
            (Route<dynamic> route) => false,
      );
    }
  }

  bool _checkServerResponse(String value) {
    if (value == 'false') {
      SnackMessage('Failed to get response from the server. Try again').build(context);
      return false;
    }
    return true;
  }

  Future<bool> _createNewUser() async {
    Person person = Person(_firstNameController.text, _lastNameController.text, _phoneController.text, _passwordController.text,);
    if (_emailController.text.isNotEmpty) {
      person.email = _emailController.text;
    }
    if (_marketController.text.isNotEmpty) {
      person.market = Market(_marketController.text);
    } else {
      person.market = Market('${person.firstname} ${person.lastname}');
    }

    MySocket socket = MySocket(null, Command.signUp, [jsonEncode(person)]);
    String value = await socket.sendAndReceive();
    return _checkServerResponse(value);
  }

  bool _isValidateAllFields() {
    return _firstNameStatus == FieldStatus.validate &&
        _lastNameStatus == FieldStatus.validate &&
        _phoneStatus == FieldStatus.validate &&
        _emailStatus == FieldStatus.validate &&
        _marketStatus == FieldStatus.validate &&
        _passwordStatus == FieldStatus.validate &&
        _passwordConfirmStatus == FieldStatus.validate;
  }

  void _validateAllFields() {
    _firstNameValidate();
    _lastNameValidate();
    _phoneValidate();
    _emailValidate();
    _marketValidate();
    _passwordValidate();
    _passwordConfirmValidate();
  }

  void _firstNameValidate() {
    Field.nameValidate(_firstNameController.text)
        ? _firstNameStatus = FieldStatus.validate
        : _firstNameStatus = FieldStatus.error;

    _firstNameFocus.unfocus();
  }

  void _lastNameValidate() {
    Field.nameValidate(_lastNameController.text)
        ? _lastNameStatus = FieldStatus.validate
        : _lastNameStatus = FieldStatus.error;

    _lastNameFocus.unfocus();
  }

  void _phoneValidate() {
    Field.phoneValidate(_phoneController.text)
        ? _phoneStatus = FieldStatus.validate
        : _phoneStatus = FieldStatus.error;

    _phoneFocus.unfocus();
  }

  void _emailValidate() {
    Field.emailValidate(_emailController.text, true)
        ? _emailStatus = FieldStatus.validate
        : _emailStatus = FieldStatus.error;

    _emailFocus.unfocus();
  }

  void _marketValidate() {
    Field.emailValidate(_marketController.text, true)
        ? _marketStatus = FieldStatus.validate
        : _marketStatus = FieldStatus.error;

    _marketFocus.unfocus();
  }

  void _passwordValidate() {
    Field.passwordValidate(_passwordController.text)
        ? _passwordStatus = FieldStatus.validate
        : _passwordStatus = FieldStatus.error;

    _passwordFocus.unfocus();
  }

  void _passwordConfirmValidate() {
    _passwordConfirmController.text == _passwordController.text
        ? _passwordConfirmStatus = FieldStatus.validate
        : _passwordConfirmStatus = FieldStatus.error;

    _passwordConfirmFocus.unfocus();
  }
}
