import 'package:flutter/material.dart';
import 'package:namakala/widgets/screen_setting.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return ScreenSetting.initScreen(
      context: context,
      child: Column(
        children: [
          ScreenSetting.buildTitleText('Account'),
        ],
      ),
    );
  }
}
