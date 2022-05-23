import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namakala/widgets/button.dart';
import 'package:namakala/widgets/screen_setting.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenSetting.initScreen(
      appBar: ScreenSetting.appBar(title: 'Profile'),
      context: context,
      child: Column(
        children: [
          Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              border: Border.all(),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              size: 50.0,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            'Moein Arabi',
            style: GoogleFonts.nunito(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            '+989120284896',
            style: GoogleFonts.nunito(
              fontSize: 15.0,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20.0,),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _button(
                    text: 'Account Information',
                    icon: Icons.account_circle_outlined,
                    onPressed: () {}
                ),
                const SizedBox(height: 5.0),
                _button(
                    text: 'Purchase History',
                    icon: Icons.history,
                    onPressed: () {}
                ),
                const SizedBox(height: 5.0),
                _button(
                    text: 'My Market',
                    icon: Icons.store_outlined,
                    onPressed: () {}
                ),
                const SizedBox(height: 5.0),
                _button(
                    text: 'Favorites',
                    icon: Icons.favorite_outline,
                    onPressed: () {}
                ),
                const SizedBox(height: 40.0),
                Button.signOut(onPress: () {}),
              ],
            ),
          ),
        ],
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
        height: 55.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black54,
              size: 30.0,
            ),
            const SizedBox(width: 15.0,),
            Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: 16.0,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.navigate_next,
              color: Colors.grey,
              size: 30.0,
            )
          ],
        ),
      ),
    );
  }
}
