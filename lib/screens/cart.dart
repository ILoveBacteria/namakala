import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:namakala/data/user_data.dart';
import 'package:namakala/socket/command.dart';
import 'package:namakala/socket/socket.dart';
import 'package:namakala/widgets/card/product_card.dart';
import 'package:namakala/widgets/screen_setting.dart';

import '../utilities/cart.dart';
import '../utilities/font.dart';
import '../utilities/person.dart';
import '../utilities/selected_product.dart';
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
  late Person person;

  @override
  Widget build(BuildContext context) {
    if (!_dataReceived) {
      _getDataFromServer().then((value) {
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
      onPressed: () => _checkout(),
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
    for (SelectedProduct p in cart.products) {
      ProductCard card = ProductCard(
        person,
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
      Detail.text(Icons.shopping_bag_outlined, 'Count', '${p.count}'),
      Detail.text(Icons.straighten_outlined, 'Size', p.size),
    ];

    return list;
  }

  List<Widget> _buttonList(SelectedProduct selectedProduct) {
    return <Widget>[
      IconButton(
        onPressed: () => _removeAllFromCart(selectedProduct),
        icon: const Icon(Icons.delete_outline),
        color: Colors.red,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      IconButton(
        onPressed: selectedProduct.count > 1
            ? () => _removeFromCart(selectedProduct)
            : null,
        icon: const Icon(Icons.remove),
        color: Colors.yellow,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      IconButton(
        onPressed: selectedProduct.product.count > 0
            ? () => _addToCart(selectedProduct)
            : null,
        icon: const Icon(Icons.add),
        color: Colors.green,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
    ];
  }

  void _addToCart(SelectedProduct selectedProduct) async {
    String response = await _sendAddProductDataToServer(selectedProduct);
    if (response == 'true') {
      cart.add(selectedProduct);
    } else {
      SnackMessage('Failed to add to your cart').build(context);
    }
    setState(() {});
  }

  void _removeFromCart(SelectedProduct selectedProduct) async {
    String response = await _sendRemoveProductDataToServer(selectedProduct);
    if (response == 'true') {
      cart.remove(selectedProduct);
    } else {
      SnackMessage('Failed to remove from your cart').build(context);
    }
    setState(() {});
  }

  void _removeAllFromCart(SelectedProduct selectedProduct) async {
    String response = await _sendRemoveAllProductDataToServer(selectedProduct);
    if (response == 'true') {
      cart.removeAll(selectedProduct);
    } else {
      SnackMessage('Failed to remove all from your cart').build(context);
    }
    setState(() {});
  }

  void _checkout() async {
    if (await _sendCheckoutDataToServer() == 'true') {
      cart = Cart();
    } else {
      SnackMessage('Failed to checkout your cart').build(context);
    }
    setState(() {});
  }

  Future<void> _getDataFromServer() async {
    MySocket socket = MySocket(UserData.phone, Command.profile, []);
    String response = await socket.sendAndReceive();
    if (response == 'null') {
      SnackMessage('Failed to get data from server').build(context);
      return Future.error('Failed to get data from server');
    }
    person = Person.fromJson(jsonDecode(response));
    cart = person.cart;
  }

  Future<String> _sendAddProductDataToServer(
      SelectedProduct selectedProduct) async {
    MySocket socket = MySocket(
        UserData.phone, Command.addCart, [jsonEncode(selectedProduct)]);
    String response = await socket.sendAndReceive();
    return _checkServerResponse(response, selectedProduct);
  }

  Future<String> _sendRemoveProductDataToServer(SelectedProduct selectedProduct) async {
    MySocket socket = MySocket(UserData.phone, Command.removeCart, [jsonEncode(selectedProduct)]);
    String response = await socket.sendAndReceive();
    return _checkServerResponse(response, selectedProduct);
  }

  Future<String> _sendRemoveAllProductDataToServer(SelectedProduct selectedProduct) async {
    MySocket socket = MySocket(UserData.phone, Command.removeAllCart, [jsonEncode(selectedProduct)]);
    String response = await socket.sendAndReceive();
    return _checkServerResponse(response, selectedProduct);
  }

  Future<String> _sendCheckoutDataToServer() async {
    MySocket socket = MySocket(UserData.phone, Command.checkoutCart, []);
    String response = await socket.sendAndReceive();
    return response;
  }

  String _checkServerResponse(
      String response, SelectedProduct selectedProduct) {
    if (response == 'false') {
      return response;
    }

    List<String> data = response.split(';');
    selectedProduct.product.count = int.parse(data[1]);
    return data[0];
  }
}
