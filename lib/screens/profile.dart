import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:namakala/data/user_data.dart';
import 'package:namakala/screens/account_information.dart';
import 'package:namakala/screens/my_market.dart';
import 'package:namakala/screens/product_category.dart';
import 'package:namakala/screens/purchase_history/cart_list.dart';
import 'package:namakala/screens/sign_in.dart';
import 'package:namakala/socket/command.dart';
import 'package:namakala/socket/socket.dart';
import 'package:namakala/utilities/arguments.dart';
import 'package:namakala/utilities/font.dart';
import 'package:namakala/utilities/person.dart';
import 'package:namakala/widgets/button.dart';
import 'package:namakala/widgets/screen_setting.dart';
import 'package:namakala/widgets/snack_message.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _dataReceived = false;
  late Person person;

  @override
  Widget build(BuildContext context) {
    if (!_dataReceived) {
      _getDataFromServer().then((value) {
        person = value;
        _dataReceived = true;
        setState(() {});
      });
    }

    return ScreenSetting.initScreen(
      appBar: ScreenSetting.appBar(title: 'Profile'),
      context: context,
      child: _dataReceived ? _buildMainScreen(context) : _buildWaitingScreen(),
    );
  }

  Widget _buildMainScreen(BuildContext context) {
    return Column(
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
                    '${person.firstname} ${person.lastname}',
                    style: Font.styleSubtitle1(),
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    person.phone,
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
                _userActivity(
                    title: 'Purchase', number: '${person.purchases.length}'),
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
                _userActivity(
                    title: 'Products',
                    number: '${person.market.products.length}'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15.0),
        Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              _button(
                text: 'Account Information',
                icon: Icons.account_circle_outlined,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const Account(),
                        settings: RouteSettings(
                          arguments: person,
                        )),
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
                      builder: (context) => PurchasedCartList(person),
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
                      settings: RouteSettings(
                        arguments:
                            Arguments.favoriteCategory(person, 'Favorites'),
                      ),
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
    );
  }

  Widget _buildWaitingScreen() {
    return Container();
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

  Future<Person> _getDataFromServer() async {
    MySocket socket = MySocket(UserData.phone, Command.profile, []);
    String response = await socket.sendAndReceive();
    if (response == 'null') {
      SnackMessage('Failed to get data from server').build(context);
      return Future.error('Failed to get data from server');
    }
    return Person.fromJson(jsonDecode(response));
  }
}
