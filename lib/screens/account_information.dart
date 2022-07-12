import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  late Field firstNameField;
  late Field lastNameField;
  late Field emailField;
  late Field passwordField;
  late Field passwordConfirmField;
  late Field phoneField;
  late Field marketField;
  bool _editScreen = false;
  VoidCallback? _submitButton;
  bool _obscurePassword = true;
  bool _obscurePasswordConfirm = true;
  bool controllerInitialized = false;
  late Person person;
  File? imageFile;

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
      validator: () =>
          passwordField.controller.text == passwordConfirmField.controller.text,
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
    person = ModalRoute.of(context)!.settings.arguments as Person;

    if (!controllerInitialized) {
      firstNameField.controller.text = person.firstname;
      lastNameField.controller.text = person.lastname;
      phoneField.controller.text = person.phone;
      emailField.controller.text = person.email!;
      marketField.controller.text = person.market.name;
      passwordField.controller.text = person.password;
      passwordConfirmField.controller.text = person.password;
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
        Field.labelWidget(label: label),
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
        Field.separate(),
        Field.container(
          height: 100.0,
          leftPadding: 10.0,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 80.0,
                height: 80.0,
                child: imageFile != null
                    ? Image.file(imageFile!)
                    : Image.asset('assets/images/image.png'),
              ),
              const Spacer(),
              Button.elevatedIcon(
                icon: Icons.add_photo_alternate_outlined,
                label: 'ADD IMAGE',
                color: Colors.lightGreen,
                onPressed: _getFromGallery,
              ),
            ],
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

  _getFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  void _changeButtonEnabled() {
    firstNameField.controller.text.isNotEmpty &&
            lastNameField.controller.text.isNotEmpty &&
            phoneField.controller.text.isNotEmpty &&
            emailField.controller.text.isNotEmpty &&
            marketField.controller.text.isNotEmpty &&
            passwordField.controller.text.isNotEmpty &&
            passwordConfirmField.controller.text.isNotEmpty
        ? _submitButton = () => _onSaveButtonPressed()
        : _submitButton = null;
    setState(() {});
  }

  void _onSaveButtonPressed() async {
    _validateAllFields();
    setState(() {});

    if (_isValidateAllFields()) {
      if (await _sendEditedDataToServer() == 'true') {
        _changeUserInformation();
        _editScreen = !_editScreen;
        setState(() {});
        firstNameField.status = FieldStatus.none;
        lastNameField.status = FieldStatus.none;
        phoneField.status = FieldStatus.none;
        emailField.status = FieldStatus.none;
        marketField.status = FieldStatus.none;
        passwordField.status = FieldStatus.none;
        passwordConfirmField.status = FieldStatus.none;
      } else {
        SnackMessage('Failed to edit data').build(context);
      }
    }
  }

  void _changeUserInformation() {
    person.firstname = firstNameField.controller.text;
    person.lastname = lastNameField.controller.text;
    person.phone = phoneField.controller.text;
    person.email = emailField.controller.text;
    person.market.name = marketField.controller.text;
    person.password = passwordField.controller.text;
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

  Future<String> _sendEditedDataToServer() async {
    Person editedPerson = Person(
      firstNameField.controller.text,
      lastNameField.controller.text,
      phoneField.controller.text,
      passwordField.controller.text,
    );
    editedPerson.email = emailField.controller.text;
    editedPerson.market = Market(marketField.controller.text);
    editedPerson.image = await imageFile?.readAsBytes() ?? person.image;

    MySocket socket = MySocket(
        UserData.phone, Command.editProfile, [jsonEncode(editedPerson)]);
    String response = await socket.sendAndReceive();
    return response;
  }
}
