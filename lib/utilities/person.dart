import 'package:namakala/utilities/market.dart';
import 'package:namakala/utilities/product.dart';

class Person {
  String firstname;
  String lastname;
  String? email;
  String password;
  String phone;
  Market? market;
  List<Product> purchases = [];
  List<Product> favorites = [];
  List<Product> cart = [];

  static Person samplePerson() {
    Person p = Person('Moein', 'Arabi', 'abc1234', '0123456789');
    p.cart = Product.mobileProducts;
    return p;
}

  Person(this.firstname, this.lastname, this.password, this.phone);
}