import 'package:flutter/material.dart';
import 'package:namakala/screens/purchase_history/product_list.dart';
import 'package:namakala/utilities/arguments.dart';
import 'package:namakala/widgets/empty_screen.dart';
import 'package:namakala/widgets/screen_setting.dart';

import '../../utilities/cart.dart';
import '../../utilities/font.dart';
import '../../utilities/person.dart';
import '../../widgets/button.dart';
import '../../widgets/card/detail.dart';

class PurchasedCartList extends StatelessWidget {
  final Person person;

  const PurchasedCartList(this.person, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenSetting.initScreen(
      context: context,
      appBar: ScreenSetting.appBar(context: context, title: 'Purchase History'),
      child: person.purchases.isEmpty
          ? EmptyScreen(Icons.production_quantity_limits_outlined, 'No purchases have been made yet!',).build(context)
          : _buildScreen(context),
    );
  }

  List<Detail> _details(Cart cart) {
    List<Detail> list = <Detail>[
      Detail.text(Icons.attach_money, 'Price', '${cart.sumOfPrice()}\$'),
    ];

    return list;
  }

  Widget _buildDetails(BuildContext context, Cart cart) {
    List<Widget> list = [];
    for (Detail d in _details(cart)) {
      list.add(d.build(context));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  Widget _buildTitleAndDetails(BuildContext context, Cart cart) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width - 165,
          child: Text(
            'The purchase was successful',
            style: Font.styleSubtitle1(color: Colors.green),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        _buildDetails(context, cart),
      ],
    );
  }

  Widget _buildCard(BuildContext context, Cart cart) {
    return Button.raw(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PurchasedProductList(),
            settings: RouteSettings(
              arguments: Arguments.cart(person, cart),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(
          top: 10.0,
          right: 5.0,
          left: 10.0,
          bottom: 10.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.black12, width: 1.3),
        ),
        child: Row(
          children: <Widget>[
            const SizedBox(
              width: 107.4,
              height: 107.4,
              child: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.grey,
                size: 60.0,
              ),
            ),
            const SizedBox(width: 15.0),
            _buildTitleAndDetails(context, cart),
          ],
        ),
      ),
    );
  }

  Widget _buildScreen(BuildContext context) {
    List<Widget> list = [];
    for (Cart c in person.purchases) {
      list.add(_buildCard(context, c));
      list.add(const SizedBox(height: 20.0));
    }
    return Column(children: list);
  }
}
