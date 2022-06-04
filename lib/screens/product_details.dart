import 'package:flutter/material.dart';
import 'package:namakala/data/sample_data.dart';
import 'package:namakala/utilities/decoration.dart';
import 'package:namakala/utilities/font.dart';
import 'package:namakala/widgets/screen_setting.dart';

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
  bool _favorite = false;
  List<bool> _selectedChip = [];

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)!.settings.arguments as Product;

    return ScreenSetting.initScreen(
      context: context,
      appBar: ScreenSetting.appBar(
        title: product.category,
        context: context,
        actions: <Widget>[
          IconButton(
            onPressed: () => setState(() => _favorite = !_favorite),
            icon: Icon(
              _favorite ? Icons.favorite : Icons.favorite_outline,
              color: _favorite ? Colors.red : Colors.blue,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Cart(),
              ),
            ),
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.blue,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => SampleData.person.cart
            .add(SelectedProduct(product, product.color[0], null)),
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
      ),
      child: Column(
        children: <Widget>[
          _buildImage(context, product),
          const SizedBox(height: 20.0),
          _buildTitle(product),
          const SizedBox(height: 20.0),
          _container(
            child: Column(
              children: _buildDetails(product, context),
            ),
          ),
          const SizedBox(height: 20.0),
          _buildChips(product),
          const SizedBox(height: 20.0),
          _buildMoreDetail(product),
        ],
      ),
    );
  }

  Widget _container({required Widget child}) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        decoration: containerDecoration2(),
        child: child);
  }

  Widget _buildImage(BuildContext context, Product product) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 40 / 100,
      child: Image.asset(product.image),
    );
  }

  Widget _buildTitle(Product product) {
    return _container(
      child: Column(
        children: [
          Text(
            product.name,
            style: Font.styleSubtitle1(),
          )
        ],
      ),
    );
  }

  List<Detail> _details(Product p) {
    List<Detail> list = <Detail>[
      Detail.text(Icons.store_outlined, 'Market', p.market.name),
      Detail.text(Icons.grade_outlined, 'Score', (p.score).toStringAsFixed(1)),
      Detail.text(Icons.attach_money, 'Price', '${p.price}\$'),
    ];

    return list;
  }

  List<Widget> _buildDetails(Product p, BuildContext context) {
    List<Widget> list = [];
    for (Detail d in _details(p)) {
      list.add(d.build(context));
    }

    return list;
  }

  Widget _buildMoreDetail(Product product) {
    return _container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

  List<Widget> _chipList(Product product) {
    List<Widget> chipList = [];

    for (int i = 0; i < product.color.length; i++) {
      _selectedChip.add(false);
      chipList.add(
        ChoiceChip(
          shape: const CircleBorder(),
          side: BorderSide(
            color: _selectedChip[i] ? Colors.grey : Colors.transparent,
            width: 2.0,
          ),
          label: const SizedBox(),
          elevation: _selectedChip[i] ? 5.0 : 0.0,
          backgroundColor: product.color[i],
          selectedColor: product.color[i],
          selected: _selectedChip[i],
          onSelected: (value) => setState(() {
            if (value) {
              for (int i = 0; i < _selectedChip.length; i++) {
                _selectedChip[i] = false;
              }
            }
            _selectedChip[i] = value;
          }),
        ),
      );
    }

    return chipList;
  }

  Widget _buildChips(Product product) {
    return _container(
      child: Column(
        children: <Widget>[
          Detail.text(Icons.palette_outlined, 'Color', 'Choose your color').build(context),
          Row(
            children: _chipList(product),
          ),
        ],
      ),
    );
  }
}
