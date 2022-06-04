import 'package:namakala/utilities/cart.dart';
import 'package:namakala/utilities/market.dart';
import 'package:namakala/utilities/product.dart';

class Person {
  String firstname;
  String lastname;
  String? email;
  String password;
  String phone;
  Market? market;
  List<Cart> purchases = [];
  List<Product> favorites = [];
  Cart cart = Cart();

  Person(this.firstname, this.lastname, this.password, this.phone);
}