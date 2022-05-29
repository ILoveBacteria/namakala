import 'package:flutter/material.dart';
import 'package:namakala/utilities/font.dart';
import 'package:namakala/widgets/button.dart';
import 'package:namakala/widgets/screen_setting.dart';

import '../utilities/product.dart';

class MobileCategory extends StatelessWidget {
  MobileCategory({Key? key}) : super(key: key);
  final List<Product> _products = <Product>[
    Product('iPhone 13 pro max - 512Gb', 'assets/images/iphone.png', 999),
    Product('iPhone 13 - 256Gb', 'assets/images/iphone13.png', 899),
    Product('iPhone 13 pro max - 512Gb', 'assets/images/iphone.png', 999),
    Product('iPhone 13 - 256Gb', 'assets/images/iphone13.png', 899),
    Product('iPhone 13 pro max - 512Gb', 'assets/images/iphone.png', 999),
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenSetting.initScreen(
      context: context,
      appBar: ScreenSetting.appBar(title: 'Mobile', context: context),
      child: Column(
        children: _buildWidgets(context),
      )
    );
  }

  List<Widget> _buildWidgets(BuildContext context) {
    List<Widget> list = [];
    for (int i = 0; i < _products.length; i++) {
      list.add(_product(context: context, product: _products[i]));
      list.add(const SizedBox(height: 20.0));
    }
    return list;
  }

  Widget _product({Product? product, required BuildContext context}) {
    return Stack(
      children: [
        Button.raw(
          onPressed: () => print('pressed'),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            height: 130.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.black12, width: 1.3),
            ),
            child: Row(
              children: [
                AspectRatio(
                  aspectRatio: 1/1,
                  child: SizedBox(
                    child: Image.asset(product!.image)
                  )
                ),
                const SizedBox(width: 15.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        product.name,
                        style: Font.styleSubtitle1(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      width: MediaQuery.of(context).size.width - 165,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned.fill(
          right: 5.0,
          bottom: 5.0,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Button.elevatedIcon(
              icon: Icons.add_shopping_cart,
              color: Colors.green,
              label: '${product.price}\$',
              onPressed: () {}
            ),
          ),
        )
      ],
    );
  }
}
