import 'package:namakala/utilities/person.dart';
import 'package:namakala/utilities/product.dart';

class Market {
  late Person owner;
  late String name;
  List<Product> products = [];

  Market(this.owner, this.name);

  Market.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = Person.fromJson(json['owner']);
    for (Map<String, dynamic> p in json['products']) {
      products.add(Product.fromJson(p));
    }
  }

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
