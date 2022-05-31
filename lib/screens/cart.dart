import 'package:flutter/material.dart';
import 'package:namakala/screens/product_details.dart';
import 'package:namakala/widgets/screen_setting.dart';

import '../utilities/font.dart';
import '../utilities/person.dart';
import '../utilities/product.dart';
import '../widgets/button.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return ScreenSetting.initScreen(
      context: context,
      appBar: ScreenSetting.appBar(title: 'Cart', context: context),
      child: Column(
        children: _buildProductWidgets(context: context, person: Person.samplePerson()),
      ),
    );
  }

  Widget _productWidget({Product? product, required BuildContext context}) {
    return Stack(
      children: [
        Button.raw(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProductDetail(),
              settings: RouteSettings(
                arguments: product,
              ),
            ),
          ),
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
                  children: _buildProductDetails(product),
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

  List<Widget> _buildProductWidgets({required BuildContext context, required Person person}) {
    List<Widget> list = [];
    for (int i = 0; i < person.cart.length; i++) {
      list.add(_productWidget(context: context, product: person.cart[i]));
      list.add(const SizedBox(height: 20.0));
    }
    return list;
  }

  Widget _productDetailWithIcon({required IconData icon, required String label, String? value, Color? color}) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
        ),
        Text(
          ' $label: ',
          style: Font.styleBody1(color: Colors.grey),
        ),
        value == null ? Container(width: 10.0, height: 10.0, color: color) : Text(value, style: Font.styleBody1()),
      ],
    );
  }

  List<Widget> _buildProductDetails(Product product) {
    List<Widget> list = [
      SizedBox(
        child: Text(
          product.name,
          style: Font.styleSubtitle1(),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        width: MediaQuery.of(context).size.width - 165,
      ),
      _productDetailWithIcon(icon: Icons.store_outlined, label: 'Market', value: 'product.market.name'),
      _productDetailWithIcon(icon: Icons.attach_money, label: 'Price', value: '${product.price}\$'),
      _productDetailWithIcon(icon: Icons.palette_outlined, label: 'Color', color: product.color),
    ];

    if (product.size != null) {
      list.add(_productDetailWithIcon(icon: Icons.straighten_outlined, label: 'Size', value: product.size));
    }

    return list;
  }
}
