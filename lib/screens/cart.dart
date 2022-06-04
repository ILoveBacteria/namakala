import 'package:flutter/material.dart';
import 'package:namakala/widgets/card/product_card.dart';
import 'package:namakala/widgets/screen_setting.dart';

import '../utilities/cart.dart';
import '../utilities/font.dart';
import '../utilities/person.dart';
import '../utilities/selected_product.dart';
import '../data/sample_data.dart';
import '../widgets/card/detail.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
              onPressed: () {
                _person.purchases.add(_person.cart);
                _person.cart = Cart();
                setState(() {});
              },
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
              children: _buildScreen(),
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
            Text(
              'Cart is empty!',
              style: Font.styleBody1(
                  color: const Color.fromARGB(255, 179, 179, 179)),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildScreen() {
    List<Widget> list = [];
    for (SelectedProduct p in _person.cart.products.keys) {
      ProductCard card = ProductCard(
        p.product,
        p.product.image,
        p.product.name,
        _details(p, context),
        _buttonList(p),
      );

      list.add(card.buildCard(context, setState));
      list.add(const SizedBox(height: 20.0));
    }

    list.add(
      Text(
        'Total: ${_person.cart.sumOfPrice()}\$',
        style: Font.styleSubtitle1(color: Colors.black54),
      ),
    );
    list.add(const SizedBox(height: 50.0));

    return list;
  }

  List<Detail> _details(SelectedProduct p, BuildContext context) {
    List<Detail> list = <Detail>[
      Detail.text(Icons.store_outlined, 'Market', p.product.market.name),
      Detail.text(Icons.attach_money, 'Price', '${p.product.price}\$'),
      Detail.color(Icons.palette_outlined, 'Color', p.color),
      Detail.text(
        Icons.shopping_bag_outlined,
        'Count',
        '${_person.cart.products[p]}',
      ),
      Detail.text(Icons.straighten_outlined, 'Size', p.size),
    ];

    return list;
  }

  List<Widget> _buttonList(SelectedProduct p) {
    return <Widget>[
      IconButton(
        onPressed: () {
          SampleData.products[p.product] =
              SampleData.products[p.product]! + _person.cart.products[p]!;
          _person.cart.removeAll(p);
          setState(() {});
        },
        icon: const Icon(Icons.delete_outline),
        color: Colors.red,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      IconButton(
        onPressed: _person.cart.products[p]! > 1
            ? () {
                _person.cart.remove(p);
                SampleData.products[p.product] =
                    SampleData.products[p.product]! + 1;
                setState(() {});
              }
            : null,
        icon: const Icon(Icons.remove),
        color: Colors.yellow,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      IconButton(
        onPressed: SampleData.products[p.product]! > 0
            ? () {
                _person.cart.add(p);
                SampleData.products[p.product] =
                    SampleData.products[p.product]! - 1;
                setState(() {});
              }
            : null,
        icon: const Icon(Icons.add),
        color: Colors.green,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
    ];
  }
}
