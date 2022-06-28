import 'dart:convert';

import 'package:namakala/utilities/selected_product.dart';

class Cart {
  List<SelectedProduct> products = [];

  Cart.fromJson(Map<String, dynamic> json) {
    for (var i in json['products']) {
      SelectedProduct sp = SelectedProduct.fromJson(i);
      products.add(sp);
    }
  }

  void add(SelectedProduct product) {
      // products.elementAt(products.indexOf(product))
  }

  void remove(SelectedProduct product) {
    // products[product] = products[product]! - 1;
  }

  void removeAll(SelectedProduct product) {
    products.remove(product);
  }

  int sumOfPrice() {
    int sum = 0;
    // for (SelectedProduct p in products.keys) {
    //   sum += p.product.price;
    // }
    return sum;
  }
}
