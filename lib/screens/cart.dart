import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:namakala/data/user_data.dart';
import 'package:namakala/socket/command.dart';
import 'package:namakala/socket/socket.dart';
import 'package:namakala/widgets/card/product_card.dart';
import 'package:namakala/widgets/screen_setting.dart';

import '../utilities/cart.dart';
import '../utilities/font.dart';
import '../utilities/selected_product.dart';
import '../data/sample_data.dart';
import '../widgets/card/detail.dart';
import '../widgets/snack_message.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _dataReceived = false;
  late Cart cart;

  @override
  Widget build(BuildContext context) {
    if (!_dataReceived) {
      _getDataFromServer().then((value) {
        cart = value;
        _dataReceived = true;
        setState(() {});
      });
    }

    return ScreenSetting.initScreen(
      context: context,
      appBar: ScreenSetting.appBar(title: 'Cart', context: context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: !_dataReceived || cart.products.isEmpty
          ? null
          : _buildFloatingActionButton(),
      child: _dataReceived ? _buildMainScreen() : _buildWaitingScreen(),
    );
  }

  Widget _buildWaitingScreen() {
    return Container();
  }

  Widget _buildMainScreen() {
    return cart.products.isEmpty
        ? _buildEmptyCartScreen(context)
        : Column(
      children: _buildScreen(),
    );
  }

  FloatingActionButton? _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        // _person.purchases.add(_person.cart);
        // TODO: checkout the cart send to server
        // _person.cart = Cart();
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
    for (SelectedProduct p in cart.products.keys) {
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
        'Total: ${cart.sumOfPrice()}\$',
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
        '${cart.products[p]}',
      ),
      Detail.text(Icons.straighten_outlined, 'Size', p.size),
    ];

    return list;
  }

  // TODO: Change onPressed
  List<Widget> _buttonList(SelectedProduct p) {
    return <Widget>[
      IconButton(
        onPressed: () {
          // SampleData.products[p.product] =
          //     SampleData.products[p.product]! + _person.cart.products[p]!;
          cart.removeAll(p);
          setState(() {});
        },
        icon: const Icon(Icons.delete_outline),
        color: Colors.red,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      IconButton(
        onPressed: cart.products[p]! > 1
            ? () {
                cart.remove(p);
                // SampleData.products[p.product] =
                //     SampleData.products[p.product]! + 1;
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
                cart.add(p);
                // SampleData.products[p.product] =
                //     SampleData.products[p.product]! - 1;
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

  Future<Cart> _getDataFromServer() async {
    MySocket socket = MySocket(UserData.phone, Command.cart, []);
    String response = await socket.sendAndReceive();
    if (response == 'null') {
      SnackMessage('Failed to get data from server').build(context);
      return Future.error('Failed to get data from server');
    }
    return Cart.fromJson(jsonDecode(response));
  }
}
