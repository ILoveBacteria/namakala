import 'package:flutter/material.dart';
import 'package:namakala/widgets/screen_setting.dart';

import '../utilities/product.dart';

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
        context: context,
        actions: <Widget>[
          IconButton(
            onPressed: () => setState(() => _favorite = !_favorite),
            icon: Icon(
              _favorite ? Icons.favorite : Icons.favorite_outline,
              color: _favorite ? Colors.red : Colors.blue,
            ),
          ),
        ]
      ),
      child: Container()
    );
  }
}

