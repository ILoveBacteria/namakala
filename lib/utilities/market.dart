import 'package:namakala/utilities/product.dart';

class Market {
  late String name;
  List<Product> products = [];

  Market(this.name);

  Market.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    for (Map<String, dynamic> p in json['products']) {
      products.add(Product.fromJson(p));
    }
  }

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
