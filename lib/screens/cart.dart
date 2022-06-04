import 'package:flutter/material.dart';
import 'package:namakala/widgets/card/product_card.dart';
import 'package:namakala/widgets/screen_setting.dart';

import '../utilities/font.dart';
import '../utilities/person.dart';
import '../utilities/selected_product.dart';
import '../data/sample_data.dart';
import '../widgets/card/detail.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final Person _person = SampleData.person;

  @override
  Widget build(BuildContext context) {
    return ScreenSetting.initScreen(
      context: context,
      appBar: ScreenSetting.appBar(title: 'Cart', context: context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _person.cart.products.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () {},
              backgroundColor: Colors.black,
              icon: const Icon(Icons.shopping_cart_checkout_outlined),
              extendedPadding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 3 / 10),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              label: Text(
                'CHECK OUT',
                style: Font.styleButton1(),
              ),
            ),
      child: _person.cart.products.isEmpty
          ? _buildEmptyCartScreen(context)
          : Column(
              children: _buildScreen(context: context),
            ),
    );
  }

  Widget _buildEmptyCartScreen(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          const Icon(
            Icons.production_quantity_limits_outlined,
            size: 100.0,
            color: Color.fromARGB(255, 179, 179, 179),
          ),
          Text('Cart is empty!', style: Font.styleBody1(color: const Color.fromARGB(255, 179, 179, 179))),
        ]),
      ),
    );
  }

  Widget _buildProductCard(
      {required Widget card, required BuildContext context}) {
    return Stack(
      children: [
        card,
        Positioned.fill(
          right: 5.0,
          bottom: 5.0,
          child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: _buttonList(),
              )),
        )
      ],
    );
  }

  List<Widget> _buildScreen({required BuildContext context}) {
    List<Widget> list = [];
    for (SelectedProduct p in _person.cart.products.keys) {
      ProductCard card = ProductCard(
        p.product,
        p.product.image,
        p.product.name,
        _details(p, context),
      );

      list.add(
          _buildProductCard(card: card.buildCard(context), context: context));
      list.add(const SizedBox(height: 20.0));
    }
    return list;
  }

  List<Detail> _details(SelectedProduct p, BuildContext context) {
    List<Detail> list = <Detail>[
      Detail.text(Icons.store_outlined, 'Market', p.product.market.name),
      Detail.text(Icons.attach_money, 'Price', '${p.product.price}\$'),
      Detail.color(Icons.palette_outlined, 'Color', p.color),
      Detail.text(
          Icons.shopping_bag_outlined, 'Count', '${_person.cart.products[p]}'),
      Detail.text(Icons.straighten_outlined, 'Size', p.size),
    ];

    return list;
  }

  List<Widget> _buttonList() {
    return <Widget>[
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.delete_outline),
        color: Colors.red,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.remove),
        color: Colors.yellow,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.add),
        color: Colors.green,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
    ];
  }
}
