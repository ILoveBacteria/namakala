import 'package:flutter/material.dart';
import 'package:namakala/data/sample_data.dart';
import 'package:namakala/utilities/decoration.dart';
import 'package:namakala/utilities/font.dart';
import 'package:namakala/widgets/screen_setting.dart';

import '../utilities/product.dart';
import '../utilities/selected_product.dart';
import 'cart.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool _favorite = false;

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
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => SampleData.person.cart.add(SelectedProduct(product, product.color[0], null)),
        backgroundColor: Colors.green,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_shopping_cart_outlined),
            Text(
              '${product.price}\$',
              style: Font.styleButton1(),
            ),
          ],
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 40 / 100,
            child: Image.asset(product.image),
          ),
          const SizedBox(height: 20.0),
          _container(
            child: Column(
              children: [
                Text(
                  product.name,
                  style: Font.styleSubtitle1(),
                )
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          _container(
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.store_outlined,
                      color: Colors.grey,
                    ),
                    Text(
                      ' Market: ',
                      style: Font.styleBody1(color: Colors.grey),
                    ),
                    Text(
                      'product.market.name',
                      style: Font.styleBody1(),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.grade_outlined,
                      color: Colors.grey,
                    ),
                    Text(
                      ' Score: ',
                      style: Font.styleBody1(color: Colors.grey),
                    ),
                    Text(
                      (product.score).toStringAsFixed(1),
                      style: Font.styleBody1(),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.attach_money,
                      color: Colors.grey,
                    ),
                    Text(
                      ' Price: ',
                      style: Font.styleBody1(color: Colors.grey),
                    ),
                    Text(
                      '${product.price}\$',
                      style: Font.styleBody1(),
                    )
                  ],
                ),
              ],
            )
          ),
          const SizedBox(height: 20.0),
          _container(
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
          ),
        ],
      )
    );
  }

  Widget _container({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: containerDecoration2(),
      child: child
    );
  }
}

