import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namakala/widgets/button.dart';
import 'package:namakala/widgets/screen_setting.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return ScreenSetting.initScreenWithSliverBar(
      appBar: ScreenSetting.sliverAppBar(),
      context: context,
      child: Column(
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
              onPress: () {}
            ),
          )
        ],
      ),
    );
  }

  Widget _userInformation({required String label, required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.nunito(
              color: Colors.grey,
              fontSize: 17.0,
              fontWeight: FontWeight.w700
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          text,
          style: GoogleFonts.nunito(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w600
          ),
        ),
      ],
    );
  }
}
