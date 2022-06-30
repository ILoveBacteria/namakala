import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:namakala/screens/add_product.dart';
import 'package:namakala/utilities/arguments.dart';
import 'package:namakala/widgets/screen_setting.dart';

import '../data/user_data.dart';
import '../socket/command.dart';
import '../socket/socket.dart';
import '../utilities/font.dart';
import '../utilities/person.dart';
import '../utilities/product.dart';
import '../widgets/card/detail.dart';
import '../widgets/card/product_card.dart';
import '../widgets/snack_message.dart';

class MyMarket extends StatefulWidget {
  const MyMarket({Key? key}) : super(key: key);

  @override
  State<MyMarket> createState() => _MyMarketState();
}

class _MyMarketState extends State<MyMarket> {
  List<Product> products = [];
  late Person person;

  @override
  Widget build(BuildContext context) {
    person = ModalRoute.of(context)!.settings.arguments as Person;
    products = person.market.products;

    return ScreenSetting.initScreen(
      context: context,
      appBar: ScreenSetting.appBar(
        title: 'My Market',
        context: context,
        actions: _actionButtons(),
      ),
      child: products.isEmpty
          ? _buildEmptyMarketScreen(context)
          : _buildMainScreen(),
    );
  }

  Widget _buildEmptyMarketScreen(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.store_outlined,
              size: 100.0,
              color: Color.fromARGB(255, 179, 179, 179),
            ),
            Text(
              'You don\'t have any products yet',
              style: Font.styleBody1(
                  color: const Color.fromARGB(255, 179, 179, 179)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainScreen() {
    return Column(
      children: _buildScreenWidgets(context),
    );
  }

  List<Widget> _buildScreenWidgets(BuildContext context) {
    List<Widget> list = [];
    for (Product p in products) {
      ProductCard card = ProductCard(
        person,
        p,
        p.image,
        p.name,
        _details(p, context),
        _buttonList(p),
      );

      list.add(card.buildCard(context, setState));
      list.add(const SizedBox(height: 20.0));
    }
    return list;
  }

  List<Detail> _details(
    Product p,
    BuildContext context,
  ) {
    List<Detail> list = <Detail>[
      Detail.text(Icons.attach_money, 'Price', '${p.price}\$'),
      Detail.text(Icons.shopping_bag_outlined, 'Remain', '${p.count}'),
    ];

    return list;
  }

  List<Widget> _actionButtons() {
    return <Widget>[
      IconButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddProduct(),
            settings: RouteSettings(
              arguments: Arguments.person(person),
            ),
          ),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.blue,
        ),
      ),
    ];
  }

  List<Widget> _buttonList(Product product) {
    return <Widget>[
      IconButton(
        onPressed: () => _removeFromMarket(product),
        icon: const Icon(Icons.delete_outline),
        color: Colors.red,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      const IconButton(
        onPressed: null,
        icon: Icon(Icons.edit_note),
        color: Colors.yellow,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      IconButton(
        onPressed: () => _onPressFavoriteButton(product),
        icon: Icon(
          person.favorites.contains(product)
              ? Icons.favorite
              : Icons.favorite_outline,
          color: person.favorites.contains(product) ? Colors.red : Colors.blue,
        ),
      ),
    ];
  }

  void _removeFromMarket(Product product) async {
    String response = await _sendRemoveProductDataToServer(product);
    if (response == 'true') {
      products.remove(product);
    } else {
      SnackMessage('Failed to remove from your market').build(context);
    }
    setState(() {});
  }

  void _onPressFavoriteButton(Product product) async {
    // Add product to person.favorites if not already added or remove if already added
    if (person.favorites.contains(product)) {
      String response = await _sendRemoveFavoriteDataToServer(product);
      if (response == 'true') {
        person.favorites.remove(product);
        setState(() {});
      } else {
        SnackMessage('Failed to remove this from favorites').build(context);
      }
    } else {
      String response = await _sendAddFavoriteDataToServer(product);
      if (response == 'true') {
        person.favorites.add(product);
        setState(() {});
      } else {
        SnackMessage('Failed to add this to favorites').build(context);
      }
    }
  }

  Future<String> _sendRemoveProductDataToServer(Product product) async {
    MySocket socket = MySocket(
        UserData.phone, Command.removeProductMarket, [jsonEncode(product)]);
    String response = await socket.sendAndReceive();
    return response;
  }

  Future<String> _sendAddFavoriteDataToServer(Product product) async {
    MySocket socket =
        MySocket(UserData.phone, Command.addFavorites, [jsonEncode(product)]);
    String response = await socket.sendAndReceive();
    return response;
  }

  Future<String> _sendRemoveFavoriteDataToServer(Product product) async {
    MySocket socket = MySocket(
        UserData.phone, Command.removeFavorites, [jsonEncode(product)]);
    String response = await socket.sendAndReceive();
    return response;
  }
}
