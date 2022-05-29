import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ScreenSetting.initScreenWithSliverBar(
        appBar: ScreenSetting.sliverAppBar(context: context),
        context: context,
        child: _mainStateWidget(),
      )
    );
  }

  Widget _mainStateWidget() {
    return _editScreen ? _userEditInformationWidgets() : _userInformationWidgets();
  }

  Widget _userInformation({required String label, required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Field.label(label: label),
        const SizedBox(height: 5.0),
        Text(
          text,
          style: Font.styleBody1()
        ),
      ],
    );
  }

  Widget _userInformationWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _userInformation(label: 'Name', text: 'Moein Arabi'),
        const Divider(color: Colors.grey),
        _userInformation(label: 'Phone', text: '+989120284896'),
        const Divider(color: Colors.grey),
        _userInformation(label: 'Email', text: 'moein.mo81@gmail.com'),
        const Divider(color: Colors.grey),
        _userInformation(label: 'Password', text: 'wsds#vd45'),
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
      children: [
        Field.firstName(initialValue: 'Moein'),
        Field.separate(),
        Field.lastName(initialValue: 'Arabi'),
        Field.separate(),
        Field.phone(initialValue: '+989120284896'),
        Field.separate(),
        Field.email(initialValue: 'moein.mo81@gmail.com'),
        Button.separate(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button.elevated(
              text: 'SAVE',
              color: Colors.lightBlueAccent,
              onPressed: () => setState(() {
              _editScreen = !_editScreen;
              })
            ),
            const SizedBox(width: 10.0),
            Button.outlined(
              text: 'CANCEL',
              color: Colors.redAccent,
              onPressed: () => setState(() {
                _editScreen = !_editScreen;
              })
            ),
          ],
        )
      ],
    );
  }
}
