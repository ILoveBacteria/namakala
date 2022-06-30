import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:namakala/data/user_data.dart';
import 'package:namakala/utilities/font.dart';
import 'package:namakala/widgets/button.dart';
import 'package:namakala/widgets/field.dart';
import 'package:namakala/widgets/screen_setting.dart';
import 'package:namakala/widgets/snack_message.dart';

import '../socket/command.dart';
import '../socket/socket.dart';
import '../utilities/market.dart';
import '../utilities/person.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool _editScreen = false;
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
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _marketController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmController;
  VoidCallback? _submitButton;
  bool _obscurePassword = true;
  bool _obscurePasswordConfirm = true;
  bool controllerInitialized = false;
  late Person person;

  @override
  Widget build(BuildContext context) {
    person = ModalRoute.of(context)!.settings.arguments as Person;

    if (!controllerInitialized) {
      _firstNameController = TextEditingController(text: person.firstname);
      _lastNameController = TextEditingController(text: person.lastname);
      _phoneController = TextEditingController(text: person.phone);
      _emailController = TextEditingController(text: person.email);
      _marketController = TextEditingController(text: person.market.name);
      _passwordController = TextEditingController(text: person.password);
      _passwordConfirmController = TextEditingController(text: person.password);
      controllerInitialized = true;
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ScreenSetting.initScreenWithSliverBar(
        appBar: ScreenSetting.sliverAppBar(
          context: context,
          background: Image.memory(person.image!),
        ),
        context: context,
        child: _mainStateWidget(),
      ),
    );
  }

  Widget _mainStateWidget() {
    return _editScreen
        ? _userEditInformationWidgets()
        : _userInformationWidgets();
  }

  Widget _userInformation({required String label, required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Field.label(label: label),
        const SizedBox(height: 5.0),
        Text(
          text,
          style: Font.styleBody1(),
        ),
      ],
    );
  }

  Widget _userInformationWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _userInformation(
            label: 'Name', text: '${person.firstname} ${person.lastname}'),
        const Divider(color: Colors.grey),
        _userInformation(label: 'Phone', text: person.phone),
        const Divider(color: Colors.grey),
        _userInformation(label: 'Market', text: person.market.name),
        const Divider(color: Colors.grey),
        _userInformation(label: 'Email', text: person.email ?? 'Not set'),
        const Divider(color: Colors.grey),
        _userInformation(label: 'Password', text: person.password),
        Button.separate(),
        Center(
          child: Button.elevatedIcon(
            icon: Icons.edit,
            label: 'EDIT',
            color: Colors.blueGrey,
            onPressed: () => setState(() {
              _editScreen = !_editScreen;
            }),
          ),
        )
      ],
    );
  }

  Widget _userEditInformationWidgets() {
    return Column(
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
          onChanged: (_) {
            _emailStatus = FieldStatus.none;
            _changeButtonEnabled();
            setState(() {});
          },
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
          onChanged: (_) {
            _marketStatus = FieldStatus.none;
            _changeButtonEnabled();
            setState(() {});
          },
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
        ),
        Button.separate(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Button.elevated(
              text: 'SAVE',
              color: Colors.lightBlueAccent,
              onPressed: _submitButton,
            ),
            const SizedBox(width: 10.0),
            Button.outlined(
              text: 'CANCEL',
              color: Colors.redAccent,
              onPressed: () => setState(() {
                _editScreen = !_editScreen;
              }),
            ),
          ],
        )
      ],
    );
  }

  void _changeButtonEnabled() {
    setState(() {
      _firstNameController.text.isNotEmpty &&
              _lastNameController.text.isNotEmpty &&
              _phoneController.text.isNotEmpty &&
              _emailController.text.isNotEmpty &&
              _marketController.text.isNotEmpty &&
              _passwordController.text.isNotEmpty &&
              _passwordConfirmController.text.isNotEmpty
          ? _submitButton = () => _onSaveButtonPressed()
          : _submitButton = null;
    });
  }

  void _onSaveButtonPressed() async {
    _validateAllFields();
    setState(() {});

    if (_isValidateAllFields()) {
      if (await _sendEditedDataToServer() == 'true') {
        _changeUserInformation();
        _editScreen = !_editScreen;
        setState(() {});
        _firstNameStatus = FieldStatus.none;
        _lastNameStatus = FieldStatus.none;
        _phoneStatus = FieldStatus.none;
        _emailStatus = FieldStatus.none;
        _marketStatus = FieldStatus.none;
        _passwordStatus = FieldStatus.none;
        _passwordConfirmStatus = FieldStatus.none;
      } else {
        SnackMessage('Failed to edit data').build(context);
      }
    }
  }

  void _changeUserInformation() {
    person.firstname = _firstNameController.text;
    person.lastname = _lastNameController.text;
    person.phone = _phoneController.text;
    person.email = _emailController.text;
    person.market.name = _marketController.text;
    person.password = _passwordController.text;
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
    Field.emailValidate(_emailController.text, false)
        ? _emailStatus = FieldStatus.validate
        : _emailStatus = FieldStatus.error;

    _emailFocus.unfocus();
  }

  void _marketValidate() {
    Field.marketValidate(_marketController.text, false)
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

  Future<String> _sendEditedDataToServer() async {
    Person person = Person(
      _firstNameController.text,
      _lastNameController.text,
      _phoneController.text,
      _passwordController.text,
    );
    person.email = _emailController.text;
    person.market = Market(_marketController.text);

    MySocket socket =
        MySocket(UserData.phone, Command.editProfile, [jsonEncode(person)]);
    String response = await socket.sendAndReceive();
    return response;
  }
}
