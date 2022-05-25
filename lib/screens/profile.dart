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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
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
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  _userActivity(title: 'Purchase', number: '5'),
                  const Spacer(),
                  const VerticalDivider(
                    color: Colors.grey,
                  ),
                  const Spacer(),
                  _userActivity(title: 'Sold', number: '2'),
                  const Spacer(),
                  const VerticalDivider(
                    color: Colors.grey,
                  ),
                  const Spacer(),
                  _userActivity(title: 'Products', number: '10'),
                ],
              ),
            ),
          ),
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
                Button.separate(),
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
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
            const SizedBox(width: 15.0),
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

  Widget _userActivity({required String title, required String number}) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.nunito(
            color: Colors.black38,
            fontSize: 17.0,
            fontWeight: FontWeight.w700
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          number,
          style: GoogleFonts.nunito(
            color: Colors.black54,
            fontSize: 17.0,
            fontWeight: FontWeight.w600
          ),
        ),
      ],
    );
  }
}
