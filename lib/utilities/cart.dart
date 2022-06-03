import 'package:namakala/utilities/selected_product.dart';

class Cart {
  Map<SelectedProduct, int> products = {};
  
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
}