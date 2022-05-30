import 'package:flutter/material.dart';
import 'package:namakala/widgets/screen_setting.dart';

import '../utilities/font.dart';
import '../utilities/product.dart';
import '../widgets/button.dart';

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
        children: _buildProductWidgets(context: context),
      )
    );
  }

  Widget _productWidget({Product? product, required BuildContext context}) {
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

  List<Widget> _buildProductWidgets({required BuildContext context}) {
    List<Widget> list = [];
    for (int i = 0; i < _products.length; i++) {
      list.add(_productWidget(context: context, product: _products[i]));
      list.add(const SizedBox(height: 20.0));
    }
    return list;
  }

  List<Product> _getProductList() {
    if (_category == 'Mobiles') {
      return Product.mobileProducts;
    }

    return [];
  }
}
