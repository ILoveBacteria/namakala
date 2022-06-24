import 'dart:convert';

import 'package:namakala/utilities/selected_product.dart';

class Cart {
  Map<SelectedProduct, int> products = {};

  Cart.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> map = json['products'];

    for (var keyJson in map.keys) {
      SelectedProduct sp = SelectedProduct.fromJson(jsonDecode(keyJson));
      products[sp] = map[keyJson]!;
    }
  }

  void add(SelectedProduct product) {
    if (products.containsKey(product)) {
      products[product] = products[product]! + 1;
      return;
    }

    products[product] = 1;
  }

  void remove(SelectedProduct product) {
    products[product] = products[product]! - 1;
  }

  void removeAll(SelectedProduct product) {
    products.remove(product);
  }

  int sumOfPrice() {
    int sum = 0;
    for (SelectedProduct p in products.keys) {
      sum += p.product.price;
    }
    return sum;
  }
}
