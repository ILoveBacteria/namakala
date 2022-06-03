import 'package:flutter/material.dart';
import 'package:namakala/widgets/card/detail.dart';

import '../../screens/product_details.dart';
import '../../utilities/font.dart';
import '../../utilities/product.dart';
import '../button.dart';

class ProductCard {
  Product product;
  String image;
  String title;
  List<Detail> details;

  ProductCard(this.product, this.image, this.title, this.details);

  Widget _buildDetails(BuildContext context) {
    List<Widget> list = [];
    for (Detail d in details) {
      list.add(d.build(context));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  Widget _buildTitleAndDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          child: Text(
            title,
            style: Font.styleSubtitle1(),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          width: MediaQuery.of(context).size.width - 165,
        ),
        _buildDetails(context),
      ],
    );
  }

  Widget buildCard(BuildContext context) {
    return Button.raw(
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
        padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0, bottom: 50.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.black12, width: 1.3),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 107.4,
              height: 107.4,
              child: Image.asset(image),
            ),
            const SizedBox(width: 15.0),
            _buildTitleAndDetails(context),
          ],
        ),
      ),
    );
  }
}
