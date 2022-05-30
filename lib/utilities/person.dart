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

  Person(this.firstname, this.lastname, this.password, this.phone);
}