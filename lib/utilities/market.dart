import 'package:namakala/utilities/person.dart';
import 'package:namakala/utilities/product.dart';

class Market {
  Person owner;
  String name;
  List<Product> products = [];

  Market(this.owner, this.name);

  Market.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        owner = Person.fromJson(json['owner']);

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
