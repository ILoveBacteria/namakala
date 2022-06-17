import 'package:namakala/utilities/selected_product.dart';

class Cart {
  late Map<SelectedProduct, int> products;

  Cart.fromJson(Map<String, dynamic> json) {
    Map<Map<String, dynamic>, int> productEntities = json['products'];

    for (var key in productEntities.keys) {
      SelectedProduct sp = SelectedProduct.fromJson(key);
      products[sp] = productEntities[key]!;
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
