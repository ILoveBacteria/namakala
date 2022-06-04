import 'package:flutter/material.dart';
import 'package:namakala/data/sample_data.dart';
import 'package:namakala/widgets/screen_setting.dart';

import '../utilities/product.dart';
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
    Map<Product, int> products = _getProductMap(category);

    return ScreenSetting.initScreen(
      context: context,
      appBar: ScreenSetting.appBar(title: category, context: context),
      child: Column(
        children: _buildScreen(context, products),
      ),
    );
  }

  List<Widget> _buildScreen(BuildContext context, Map<Product, int> products) {
    List<Widget> list = [];
    for (Product p in products.keys) {
      ProductCard card = ProductCard(
        p,
        p.image,
        p.name,
        _details(products, p, context),
        _buttonList(p),
      );

      list.add(card.buildCard(context, setState));
      list.add(const SizedBox(height: 20.0));
    }
    return list;
  }

  Map<Product, int> _getProductMap(String category) {
    Map<Product, int> map = {};

    if (category == 'Favorites') {
      for (Product p in SampleData.products.keys) {
        if (SampleData.person.favorites.contains(p)) {
          map[p] = SampleData.products[p]!;
        }
      }
    } else {
      for (Product p in SampleData.products.keys) {
        if (p.category == category) {
          map[p] = SampleData.products[p]!;
        }
      }
    }

    return map;
  }

  List<Detail> _details(
    Map<Product, int> products,
    Product p,
    BuildContext context,
  ) {
    List<Detail> list = <Detail>[
      Detail.text(Icons.attach_money, 'Price', '${p.price}\$'),
      Detail.text(Icons.shopping_bag_outlined, 'Remain', '${products[p]}'),
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
          SampleData.person.favorites.contains(product)
              ? Icons.favorite
              : Icons.favorite_outline,
          color: SampleData.person.favorites.contains(product)
              ? Colors.red
              : Colors.blue,
        ),
      ),
    ];
  }
}
