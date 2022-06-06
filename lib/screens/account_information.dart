import 'package:flutter/material.dart';
import 'package:namakala/data/sample_data.dart';
import 'package:namakala/utilities/font.dart';
import 'package:namakala/widgets/button.dart';
import 'package:namakala/widgets/field.dart';
import 'package:namakala/widgets/screen_setting.dart';

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
  final _passwordFocus = FocusNode();
  final _passwordConfirmFocus = FocusNode();
  FieldStatus _firstNameStatus = FieldStatus.none;
  FieldStatus _lastNameStatus = FieldStatus.none;
  FieldStatus _phoneStatus = FieldStatus.none;
  FieldStatus _emailStatus = FieldStatus.none;
  FieldStatus _passwordStatus = FieldStatus.none;
  FieldStatus _passwordConfirmStatus = FieldStatus.none;
  final _firstNameController = TextEditingController(text: SampleData.person.firstname);
  final _lastNameController = TextEditingController(text: SampleData.person.lastname);
  final _phoneController = TextEditingController(text: SampleData.person.phone);
  final _emailController = TextEditingController(text: SampleData.person.email);
  final _passwordController = TextEditingController(text: SampleData.person.password);
  final _passwordConfirmController = TextEditingController(text: SampleData.person.password);
  VoidCallback? _submitButton;
  bool _obscurePassword = true;
  bool _obscurePasswordConfirm = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ScreenSetting.initScreenWithSliverBar(
          appBar: ScreenSetting.sliverAppBar(context: context),
          context: context,
          child: _mainStateWidget(),
        ));
  }

  Widget _mainStateWidget() {
    return _editScreen
        ? _userEditInformationWidgets()
        : _userInformationWidgets();
  }

  Widget _userInformation({required String label, required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Field.label(label: label),
        const SizedBox(height: 5.0),
        Text(text, style: Font.styleBody1()),
      ],
    );
  }

  Widget _userInformationWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _userInformation(label: 'Name', text: '${SampleData.person.firstname} ${SampleData.person.lastname}'),
        const Divider(color: Colors.grey),
        _userInformation(label: 'Phone', text: SampleData.person.phone),
        const Divider(color: Colors.grey),
        _userInformation(label: 'Email', text: SampleData.person.email ?? 'Not set'),
        const Divider(color: Colors.grey),
        _userInformation(label: 'Password', text: SampleData.person.password),
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
            setState(() {
              Field.nameValidate(_firstNameController.text)
                  ? _firstNameStatus = FieldStatus.validate
                  : _firstNameStatus = FieldStatus.error;

              _firstNameFocus.unfocus();
            });
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
            setState(() {
              Field.nameValidate(_lastNameController.text)
                  ? _lastNameStatus = FieldStatus.validate
                  : _lastNameStatus = FieldStatus.error;

              _lastNameFocus.unfocus();
            });
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
          obscureText: _obscurePassword,
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
            setState(() {
              _passwordConfirmController.text ==
                  _passwordController.text
                  ? _passwordConfirmStatus = FieldStatus.validate
                  : _passwordConfirmStatus = FieldStatus.error;

              _passwordConfirmFocus.unfocus();
            });
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              _passwordController.text.isNotEmpty &&
              _passwordConfirmController.text.isNotEmpty
          ? _submitButton = () {
              _editScreen = !_editScreen;
              setState(() {});
            }
          : _submitButton = null;
    });
  }
}
