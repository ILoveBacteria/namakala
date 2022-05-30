import 'package:namakala/utilities/person.dart';
import 'package:namakala/utilities/product.dart';

class Market {
  Person owner;
  String name;
  List<Product> products = [];

  Market(this.owner, this.name);
}