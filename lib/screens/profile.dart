import 'package:flutter/material.dart';
import 'package:namakala/data/sample_data.dart';
import 'package:namakala/screens/account_information.dart';
import 'package:namakala/screens/my_market.dart';
import 'package:namakala/screens/product_category.dart';
import 'package:namakala/screens/purchase_history/cart_list.dart';
import 'package:namakala/screens/sign_in.dart';
import 'package:namakala/utilities/font.dart';
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
                      '${SampleData.person.firstname} ${SampleData.person.lastname}',
                      style: Font.styleSubtitle1(),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      SampleData.person.phone,
                      style: Font.styleBody2(color: Colors.grey),
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
                  _userActivity(title: 'Purchase', number: '${SampleData.person.purchases.length}'),
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
                  _userActivity(title: 'Products', number: '${SampleData.person.market?.products.length ?? 0}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _button(
                  text: 'Account Information',
                  icon: Icons.account_circle_outlined,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Account(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20.0),
                _button(
                  text: 'Purchase History',
                  icon: Icons.history,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PurchasedCartList(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20.0),
                _button(
                  text: 'My Market',
                  icon: Icons.store_outlined,
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MyMarket(),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                _button(
                  text: 'Favorites',
                  icon: Icons.favorite_outline,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ProductCategory(),
                        settings: const RouteSettings(arguments: 'Favorites'),
                      ),
                    );
                  },
                ),
                Button.separate(),
                Button.signOut(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const SignIn()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
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
    required VoidCallback onPressed,
  }) {
    return Button.raw(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        width: double.infinity,
        height: 50.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.black54,
              size: 26.0,
            ),
            const SizedBox(width: 15.0),
            Text(
              text,
              style: Font.styleButton2(color: Colors.black54),
            ),
            const Spacer(),
            const Icon(
              Icons.navigate_next,
              color: Colors.grey,
              size: 26.0,
            )
          ],
        ),
      ),
    );
  }

  Widget _userActivity({required String title, required String number}) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: Font.styleSubtitle2(color: Colors.black38),
        ),
        const SizedBox(height: 5.0),
        Text(
          number,
          style: Font.styleBody1(color: Colors.black54),
        ),
      ],
    );
  }
}
