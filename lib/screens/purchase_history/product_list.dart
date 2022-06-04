import 'package:flutter/material.dart';
import 'package:namakala/widgets/screen_setting.dart';

import '../../data/sample_data.dart';
import '../../utilities/cart.dart';
import '../../utilities/person.dart';
import '../../utilities/product.dart';
import '../../utilities/selected_product.dart';
import '../../widgets/card/detail.dart';
import '../../widgets/card/product_card.dart';

class PurchasedProductList extends StatefulWidget {
  const PurchasedProductList({Key? key}) : super(key: key);

  @override
  State<PurchasedProductList> createState() => _PurchasedProductListState();
}

class _PurchasedProductListState extends State<PurchasedProductList> {
  final Person person = SampleData.person;
  final Cart cart = SampleData.person.purchases[0];

  @override
  Widget build(BuildContext context) {
    return ScreenSetting.initScreen(
      context: context,
      appBar: ScreenSetting.appBar(context: context, title: 'Products'),
      child: Column(
        children: _buildScreen(),
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
        _buttonList(p.product),
      );

      list.add(card.buildCard(context, setState));
      list.add(const SizedBox(height: 20.0));
    }
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
