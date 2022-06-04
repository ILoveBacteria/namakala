import 'package:flutter/material.dart';
import 'package:namakala/data/sample_data.dart';
import 'package:namakala/widgets/screen_setting.dart';

import '../utilities/font.dart';
import '../utilities/person.dart';
import '../utilities/product.dart';
import '../utilities/selected_product.dart';
import '../widgets/card/detail.dart';
import '../widgets/card/product_card.dart';

class ProductCategory extends StatefulWidget {
  const ProductCategory({Key? key}) : super(key: key);

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  @override
  Widget build(BuildContext context) {
    String category = ModalRoute.of(context)!.settings.arguments as String;
    List<Product> products = _getProductList(category);

    return ScreenSetting.initScreen(
      context: context,
      appBar: ScreenSetting.appBar(title: category, context: context),
      child: Column(
        children: _buildScreen(context, products),
      ),
    );
  }

  List<Widget> _buildScreen(BuildContext context, List<Product> products) {
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

  List<Product> _getProductList(String category) {
    if (category == 'Mobiles') {
      return SampleData.mobileProducts;
    } else if (category == 'Laptops') {
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

  List<Widget> _buttonList(Product product) {
    return <Widget>[
      IconButton(
        onPressed: () {
          setState(() {
            // Add product to person.favorites if not already added or remove if already added
            if (SampleData.person.favorites.contains(product)) {
              SampleData.person.favorites.remove(product);
            } else {
              SampleData.person.favorites.add(product);
            }
          });
        },
        icon: Icon(
          SampleData.person.favorites.contains(product) ? Icons.favorite : Icons.favorite_outline,
          color: SampleData.person.favorites.contains(product) ? Colors.red : Colors.blue,
        ),
      ),
    ];
  }
}
