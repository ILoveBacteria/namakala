import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namakala/widgets/screen_setting.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50.0,
            bottom: 10.0
          ),
          child: Column(
            children: [
              ScreenSetting.buildTitleText('Profile'),
              const SizedBox(height: 50.0,),
              Container(
                width: 100.0,
                height: 100.0,
                decoration: const BoxDecoration(
                  color: Colors.cyanAccent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: 20.0,),
              const Text('Moein Arabi'),
              const SizedBox(height: 10.0,),
              const Text('+989120284896'),
              const SizedBox(height: 20.0,),
              Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                height: 300.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.green,
                ),
                child: Column(
                  children: [
                    _button(
                        text: 'Account Information',
                        icon: Icons.account_circle_outlined,
                        onPressed: () {}
                    ),
                    const SizedBox(height: 20.0,),
                    _button(
                        text: 'Purchase History',
                        icon: Icons.history,
                        onPressed: () {}
                    ),
                    const SizedBox(height: 20.0,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button({
    required String text,
    required IconData icon,
    required VoidCallback onPressed
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 20.0,),
            Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
