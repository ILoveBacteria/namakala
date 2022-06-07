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

  Person(this.firstname, this.lastname, this.phone, this.password);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Person &&
          runtimeType == other.runtimeType &&
          password == other.password &&
          phone == other.phone;

  @override
  int get hashCode => password.hashCode ^ phone.hashCode;
}