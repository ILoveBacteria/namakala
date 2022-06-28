import 'package:namakala/utilities/selected_product.dart';

class Cart {
  List<SelectedProduct> products = [];

  Cart.fromJson(Map<String, dynamic> json) {
    for (var i in json['products']) {
      SelectedProduct sp = SelectedProduct.fromJson(i);
      products.add(sp);
    }
  }

  void add(SelectedProduct selectedProduct) {
      for (SelectedProduct sp in products) {
        if (selectedProduct == sp) {
          sp.count++;
        }
      }
  }

  void remove(SelectedProduct selectedProduct) {
    for (SelectedProduct sp in products) {
      if (selectedProduct == sp) {
        sp.count--;
      }
    }
  }

  void removeAll(SelectedProduct product) {
    products.remove(product);
  }

  int sumOfPrice() {
    int sum = 0;
    for (SelectedProduct p in products) {
      sum += p.product.price * p.count;
    }
    return sum;
  }
}
