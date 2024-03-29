import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:namakala/data/user_data.dart';
import 'package:namakala/socket/command.dart';
import 'package:namakala/socket/socket.dart';
import 'package:namakala/utilities/arguments.dart';
import 'package:namakala/utilities/decoration.dart';
import 'package:namakala/utilities/font.dart';
import 'package:namakala/utilities/person.dart';
import 'package:namakala/widgets/favorite_button.dart';
import 'package:namakala/widgets/screen_setting.dart';
import 'package:namakala/widgets/snack_message.dart';

import '../utilities/product.dart';
import '../utilities/selected_product.dart';
import '../widgets/card/detail.dart';
import 'cart.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final List<bool> _selectedColorChip = [];
  final List<bool> _selectedSizeChip = [];
  final List<bool> _selectedScoreChip = [];
  late Product product;
  late Person person;

  @override
  Widget build(BuildContext context) {
    Arguments arguments =
    ModalRoute
        .of(context)!
        .settings
        .arguments as Arguments;
    product = arguments.product!;
    person = arguments.person!;

    return ScreenSetting.initScreen(
      context: context,
      appBar: ScreenSetting.appBar(
        title: product.category,
        context: context,
        actions: _actionButtons(),
      ),
      floatingActionButton: _buildFloatingActionButton(),
      child: _buildMainScreen(),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => _onPressFloatingButton(),
      backgroundColor: Colors.green,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.add_shopping_cart_outlined),
          Text(
            '${product.price}\$',
            style: Font.styleButton1(),
          ),
        ],
      ),
    );
  }

  Widget _buildMainScreen() {
    return Column(
      children: <Widget>[
        _buildImage(),
        const SizedBox(height: 20.0),
        _buildTitle(),
        const SizedBox(height: 20.0),
        _container(
          child: Column(
            children: _buildDetails(context),
          ),
        ),
        const SizedBox(height: 20.0),
        _buildColorChips(),
        const SizedBox(height: 20.0),
        _buildSizeChips(),
        const SizedBox(height: 20.0),
        _buildScoreChips(),
        const SizedBox(height: 20.0),
        _buildMoreDetail(),
      ],
    );
  }

  Widget _container({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: containerDecoration2(),
      child: child,
    );
  }

  Widget _buildImage() {
    return SizedBox(
      height: MediaQuery
          .of(context)
          .size
          .height * 40 / 100,
      child: Image.memory(product.image),
    );
  }

  Widget _buildTitle() {
    return _container(
      child: Column(
        children: <Widget>[
          Text(
            product.name,
            style: Font.styleSubtitle1(),
          )
        ],
      ),
    );
  }

  List<Detail> _details() {
    List<Detail> list = <Detail>[
      Detail.text(Icons.store_outlined, 'Market', product.market.name),
      Detail.text(
          Icons.grade_outlined, 'Score', (product.score).toStringAsFixed(1)),
      Detail.text(Icons.attach_money, 'Price', '${product.price}\$'),
      Detail.text(Icons.shopping_bag_outlined, 'Remain', '${product.count}'),
    ];

    return list;
  }

  List<Widget> _actionButtons() {
    return <Widget>[
      FavoriteButton(product, person).build(context, setState),
      IconButton(
        onPressed: () =>
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartScreen(),
              ),
            ).then((_) => setState(() {})),
        icon: const Icon(
          Icons.shopping_cart_outlined,
          color: Colors.blue,
        ),
      ),
    ];
  }

  List<Widget> _buildDetails(BuildContext context) {
    List<Widget> list = [];
    for (Detail d in _details()) {
      list.add(d.build(context));
    }

    return list;
  }

  Widget _buildMoreDetail() {
    return _container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'More Detail:',
            style: Font.styleBody1(color: Colors.grey),
          ),
          Text(
            product.detail,
            style: Font.styleBody2(),
          ),
        ],
      ),
    );
  }

  List<Widget> _colorChipList() {
    List<Widget> chipList = [];

    for (int i = 0; i < product.color.length; i++) {
      _selectedColorChip.add(false);
      chipList.add(
        ChoiceChip(
          shape: const CircleBorder(),
          side: BorderSide(
            color: _selectedColorChip[i] ? Colors.grey : Colors.transparent,
            width: 2.0,
          ),
          label: const SizedBox(),
          elevation: _selectedColorChip[i] ? 5.0 : 0.0,
          backgroundColor: product.color[i],
          selectedColor: product.color[i],
          selected: _selectedColorChip[i],
          onSelected: (value) =>
              setState(() {
                if (value) {
                  for (int i = 0; i < _selectedColorChip.length; i++) {
                    _selectedColorChip[i] = false;
                  }
                }
                _selectedColorChip[i] = value;
              }),
        ),
      );
    }

    return chipList;
  }

  List<Widget> _sizeChipList() {
    List<Widget> chipList = [];

    for (int i = 0; i < product.size.length; i++) {
      _selectedSizeChip.add(false);
      chipList.add(
        ChoiceChip(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          label: Text(
            product.size[i],
            style: Font.styleButton1(),
          ),
          elevation: _selectedSizeChip[i] ? 5.0 : 0.0,
          backgroundColor: Colors.grey[200],
          selected: _selectedSizeChip[i],
          onSelected: (value) =>
              setState(() {
                if (value) {
                  for (int i = 0; i < _selectedSizeChip.length; i++) {
                    _selectedSizeChip[i] = false;
                  }
                }
                _selectedSizeChip[i] = value;
              }),
        ),
      );
    }

    return chipList;
  }

  Widget _buildSizeChips() {
    return _container(
      child: Column(
        children: <Widget>[
          Detail.text(Icons.straighten_outlined, 'Size', 'Choose your size')
              .build(context),
          Row(
            children: _sizeChipList(),
          ),
        ],
      ),
    );
  }

  Widget _buildColorChips() {
    return _container(
      child: Column(
        children: <Widget>[
          Detail.text(Icons.palette_outlined, 'Color', 'Choose your color')
              .build(context),
          Row(
            children: _colorChipList(),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreChips() {
    return _container(
      child: Column(
        children: <Widget>[
          Detail.text(Icons.grade_outlined, 'Score', 'Rate this product')
              .build(context),
          Row(
            children: _scoreChipList(),
          ),
        ],
      ),
    );
  }

  List<Widget> _scoreChipList() {
    List<Widget> chipList = [];

    for (int i = 0; i < 5; i++) {
      _selectedScoreChip.add(false);
      chipList.add(
        ChoiceChip(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          label: Text(
            '${i + 1}',
            style: Font.styleButton1(),
          ),
          elevation: _selectedScoreChip[i] ? 5.0 : 0.0,
          backgroundColor: Colors.grey[200],
          selected: person.scores.contains(product.id)
              ? false
              : _selectedScoreChip[i],
          onSelected: (value) =>
              setState(() {
                if (value) {
                  for (int i = 0; i < _selectedScoreChip.length; i++) {
                    _selectedScoreChip[i] = false;
                  }
                }
                _selectedScoreChip[i] = value;
              }),
        ),
      );
    }

    Widget okButton = IconButton(
      onPressed: _selectedScoreChip.contains(true) ? () => _sendNewScoreToServer() : null,
      icon: const Icon(
        Icons.done,
        color: Colors.green,
      ),
    );

    Widget text = Text('voted!', style: Font.styleBody1(color: Colors.green),);

    chipList.add(person.scores.contains(product.id) ? text : okButton);

    return chipList;
  }

  Future<void> _sendNewScoreToServer() async {
    MySocket socket = MySocket(UserData.phone, Command.score, [jsonEncode(product) ,'${_selectedScoreChip.indexOf(true) + 1}']);
    String response = await socket.sendAndReceive();

    if (response == 'false') {
      SnackMessage('Failed to rate this product').build(context);
    } else {
      person.scores.add(product.id);
      product.score = double.parse(response);
      setState(() {});
    }
  }

  void _addToCart() async {
    int i = _selectedColorChip.indexOf(true);
    int j = _selectedSizeChip.indexOf(true);

    if (i == -1 || j == -1) {
      SnackMessage('Please select color or size!').build(context);
      return;
    }

    String response = await _sendAddProductDataToServer(
        SelectedProduct(product, product.color[i], product.size[j], 1));

    if (response == 'true') {
      SnackMessage('Successfully added to your cart').build(context);
    } else {
      SnackMessage('Failed to add to your cart').build(context);
    }

    setState(() {});
  }

  void _onPressFloatingButton() {
    if ((person.market.products.contains(product)) || product.count == 0) {
      SnackMessage('You cannot add this product to your cart').build(context);
    } else {
      _addToCart();
    }
  }

  Future<String> _sendAddProductDataToServer(
      SelectedProduct selectedProduct) async {
    MySocket socket = MySocket(
        UserData.phone, Command.addCart, [jsonEncode(selectedProduct)]);
    String response = await socket.sendAndReceive();
    return _checkServerResponse(response);
  }

  String _checkServerResponse(String response) {
    if (response == 'false') {
      return response;
    }

    List<String> data = response.split(';');
    product.count = int.parse(data[1]);
    return data[0];
  }
}
