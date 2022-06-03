import 'package:flutter/material.dart';
import 'package:namakala/data/sample_data.dart';
import 'package:namakala/widgets/screen_setting.dart';

import '../utilities/font.dart';
import '../utilities/person.dart';
import '../utilities/product.dart';
import '../utilities/selected_product.dart';
import '../widgets/card/detail.dart';
import '../widgets/card/product_card.dart';

class ProductCategory extends StatelessWidget {
  final String _category;
  late final List<Product> _products;

  ProductCategory(this._category, {Key? key}) : super(key: key) {
    _products = _getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenSetting.initScreen(
      context: context,
      appBar: ScreenSetting.appBar(title: _category, context: context),
      child: Column(
        children: _buildScreen(context: context),
      ),
    );
  }

  Widget _buildProductCard(Widget card, BuildContext context) {
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
    for (Product p in _products) {
      ProductCard card = ProductCard(
        p,
        p.image,
        p.name,
        _details(p, context),
      );

      list.add(_buildProductCard(card.buildCard(context), context));
      list.add(const SizedBox(height: 20.0));
    }
    return list;
  }

  List<Product> _getProductList() {
    if (_category == 'Mobiles') {
      return SampleData.mobileProducts;
    } else if (_category == 'Laptops') {
      return SampleData.laptopProducts;
    }

    return [];
  }

  List<Detail> _details(Product p, BuildContext context) {
    List<Detail> list = <Detail>[
      Detail.text(Icons.attach_money, 'Price', '${p.price}\$'),
      Detail.text(Icons.shopping_bag_outlined, 'Remain', '{}'),
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
