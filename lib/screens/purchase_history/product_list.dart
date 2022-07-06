import 'package:flutter/material.dart';
import 'package:namakala/utilities/arguments.dart';
import 'package:namakala/widgets/screen_setting.dart';

import '../../utilities/cart.dart';
import '../../utilities/person.dart';
import '../../utilities/product.dart';
import '../../utilities/selected_product.dart';
import '../../widgets/card/detail.dart';
import '../../widgets/card/product_card.dart';
import '../../widgets/favorite_button.dart';

class PurchasedProductList extends StatefulWidget {
  const PurchasedProductList({Key? key}) : super(key: key);

  @override
  State<PurchasedProductList> createState() => _PurchasedProductListState();
}

class _PurchasedProductListState extends State<PurchasedProductList> {
  late Person person;

  @override
  Widget build(BuildContext context) {
    Arguments arguments = ModalRoute.of(context)!.settings.arguments as Arguments;
    person = arguments.person!;
    Cart cart = arguments.cart!;

    return ScreenSetting.initScreen(
      context: context,
      appBar: ScreenSetting.appBar(context: context, title: 'Products'),
      child: Column(
        children: _buildScreen(cart),
      ),
    );
  }

  List<Widget> _buildScreen(Cart cart) {
    List<Widget> list = [];
    for (SelectedProduct p in cart.products) {
      ProductCard card = ProductCard(
        person,
        p.product,
        p.product.image,
        p.product.name,
        _details(p, cart),
        _buttonList(p.product),
      );

      list.add(card.buildCard(context, setState));
      list.add(const SizedBox(height: 20.0));
    }
    return list;
  }

  List<Detail> _details(SelectedProduct p, Cart cart) {
    List<Detail> list = <Detail>[
      Detail.text(Icons.store_outlined, 'Market', p.product.market.name),
      Detail.text(Icons.attach_money, 'Price', '${p.product.price}\$'),
      Detail.color(Icons.palette_outlined, 'Color', p.color),
      Detail.text(Icons.shopping_bag_outlined, 'Count', '${p.count}'),
      Detail.text(Icons.straighten_outlined, 'Size', p.size),
    ];

    return list;
  }

  List<Widget> _buttonList(Product product) {
    return <Widget>[
      FavoriteButton(product, person).build(context, setState),
    ];
  }
}
