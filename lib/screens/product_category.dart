import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:namakala/data/user_data.dart';
import 'package:namakala/socket/command.dart';
import 'package:namakala/socket/socket.dart';
import 'package:namakala/utilities/person.dart';
import 'package:namakala/widgets/screen_setting.dart';

import '../utilities/font.dart';
import '../utilities/product.dart';
import '../widgets/card/detail.dart';
import '../widgets/card/product_card.dart';

class ProductCategory extends StatefulWidget {
  const ProductCategory({Key? key}) : super(key: key);

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  List<Product> products = [];
  late Person person;
  bool dataReceived = false;

  @override
  Widget build(BuildContext context) {
    String category = ModalRoute.of(context)!.settings.arguments as String;

    if (!dataReceived) {
      _getAllDataFromServer(category).then((value) {
        dataReceived = true;
        setState(() {});
      });
    }

    return ScreenSetting.initScreen(
      context: context,
      appBar: ScreenSetting.appBar(title: category, context: context),
      child: dataReceived ? _buildMainScreen() : _buildWaitingScreen()
    );
  }

  Future<void> _getProductDataFromServer(String categoryName) async {
    MySocket socket = MySocket(UserData.phone, Command.category, [categoryName]);
    String response = await socket.sendAndReceive();

    for (Map<String, dynamic> i in jsonDecode(response)['products']) {
      products.add(Product.fromJson(i));
    }
  }

  Future<void> _getPersonDataFromServer() async {
    MySocket socket = MySocket(UserData.phone, Command.profile, []);
    String response = await socket.sendAndReceive();
    person = Person.fromJson(jsonDecode(response));
  }

  Future<void> _getAllDataFromServer(String categoryName) async {
    _getProductDataFromServer(categoryName);
    _getPersonDataFromServer();
  }


  Widget _buildWaitingScreen() {
    return Container();
  }

  Widget _buildMainScreen() {
    return products.isEmpty ? _buildEmptyProductScreen(context) : Column(
        children: _buildScreenWidgets(context));
  }

  List<Widget> _buildScreenWidgets(BuildContext context) {
    List<Widget> list = [];
    for (Product p in products) {
      ProductCard card = ProductCard(
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

  List<Widget> _buttonList(Product product) {
    return <Widget>[
      IconButton(
        onPressed: () {
          setState(() {
            // Add product to person.favorites if not already added or remove if already added
            if (person.favorites.contains(product)) {
              person.favorites.remove(product);
            } else {
              person.favorites.add(product);
            }
          });
        },
        icon: Icon(
          person.favorites.contains(product)
              ? Icons.favorite
              : Icons.favorite_outline,
          color: person.favorites.contains(product)
              ? Colors.red
              : Colors.blue,
        ),
      ),
    ];
  }

  Widget _buildEmptyProductScreen(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.list_alt_outlined,
              size: 100.0,
              color: Color.fromARGB(255, 179, 179, 179),
            ),
            Text(
              'List is empty!',
              style: Font.styleBody1(
                  color: const Color.fromARGB(255, 179, 179, 179)),
            ),
          ],
        ),
      ),
    );
  }
}
