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
  late Field firstNameField;
  late Field lastNameField;
  late Field emailField;
  late Field passwordField;
  late Field passwordConfirmField;
  late Field phoneField;
  late Field marketField;
  VoidCallback? _submitButton;
  bool _obscurePassword = true;
  bool _obscurePasswordConfirm = true;

  @override
  void initState() {
    super.initState();
    firstNameField = Field.firstName(
      setState: setState,
      validator: Field.nameValidate,
      changeEnablingSubmitButton: _changeButtonEnabled,
    );

    lastNameField = Field.lastName(
      setState: setState,
      validator: Field.nameValidate,
      changeEnablingSubmitButton: _changeButtonEnabled,
    );

    phoneField = Field.phone(
      setState: setState,
      validator: Field.phoneValidate,
      changeEnablingSubmitButton: _changeButtonEnabled,
    );

    emailField = Field.email(
      setState: setState,
      validator: Field.emailValidate,
      changeEnablingSubmitButton: _changeButtonEnabled,
    );

    marketField = Field.market(
      setState: setState,
      validator: Field.marketValidate,
      changeEnablingSubmitButton: _changeButtonEnabled,
    );

    passwordField = Field.password(
      obscureText: _obscurePassword,
      setState: setState,
      validator: Field.passwordValidate,
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

    passwordConfirmField = Field.passwordConfirm(
      obscureText: _obscurePasswordConfirm,
      setState: setState,
      validator: _passwordConfirmValidate,
      changeEnablingSubmitButton: _changeButtonEnabled,
      suffixButton: IconButton(
        icon: _obscurePasswordConfirm
            ? const Icon(Icons.visibility_off_outlined)
            : const Icon(Icons.visibility_outlined),
        color: Colors.grey,
        onPressed: () {
          setState(() {
            _obscurePasswordConfirm = !_obscurePasswordConfirm;
          });
        },
      ),
    );
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
                firstNameField.build(),
                Field.separate(),
                lastNameField.build(),
                Field.separate(),
                phoneField.build(),
                Field.separate(),
                emailField.build(),
                Field.separate(),
                marketField.build(),
                Field.separate(),
                passwordField.build(),
                Field.separate(),
                passwordConfirmField.build(),
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
    firstNameField.controller.text.isNotEmpty &&
            lastNameField.controller.text.isNotEmpty &&
            phoneField.controller.text.isNotEmpty &&
            emailField.controller.text.isNotEmpty &&
            marketField.controller.text.isNotEmpty &&
            passwordField.controller.text.isNotEmpty &&
            passwordConfirmField.controller.text.isNotEmpty
        ? _submitButton = () => _onSignUpButtonPressed()
        : _submitButton = null;
    setState(() {});
  }

  void _onSignUpButtonPressed() async {
    _validateAllFields();
    setState(() {});

    if (_isValidateAllFields() && await _createNewUser()) {
      UserData.phone = phoneField.controller.text;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MainScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  bool _checkServerResponse(String value) {
    if (value == 'false') {
      SnackMessage('Failed to get response from the server. Try again')
          .build(context);
      return false;
    } else if (value == 'phoneFalse') {
      SnackMessage('This phone has already used').build(context);
      phoneField.status = FieldStatus.error;
      setState(() {});
      return false;
    }
    return true;
  }

  Future<bool> _createNewUser() async {
    Person person = Person(
      firstNameField.controller.text,
      lastNameField.controller.text,
      phoneField.controller.text,
      passwordField.controller.text,
    );
    if (emailField.controller.text.isNotEmpty) {
      person.email = emailField.controller.text;
    }
    if (marketField.controller.text.isNotEmpty) {
      person.market = Market(marketField.controller.text);
    } else {
      person.market = Market('${person.firstname} ${person.lastname}');
    }

    MySocket socket = MySocket(null, Command.signUp, [jsonEncode(person)]);
    String value = await socket.sendAndReceive();
    return _checkServerResponse(value);
  }

  bool _isValidateAllFields() {
    return firstNameField.status == FieldStatus.validate &&
        lastNameField.status == FieldStatus.validate &&
        phoneField.status == FieldStatus.validate &&
        emailField.status == FieldStatus.validate &&
        marketField.status == FieldStatus.validate &&
        passwordField.status == FieldStatus.validate &&
        passwordConfirmField.status == FieldStatus.validate;
  }

  void _validateAllFields() {
    firstNameField.checkValid();
    lastNameField.checkValid();
    phoneField.checkValid();
    emailField.checkValid();
    marketField.checkValid();
    passwordField.checkValid();
    passwordConfirmField.checkValid();
  }

  bool _passwordConfirmValidate(String? value) {
    return passwordField.controller.text == value;
  }
}
