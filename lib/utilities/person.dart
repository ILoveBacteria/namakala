import 'dart:typed_data';

import 'package:namakala/utilities/cart.dart';
import 'package:namakala/utilities/market.dart';
import 'package:namakala/utilities/product.dart';

class Person {
  Uint8List? image;
  late String firstname;
  late String lastname;
  String? email;
  late String password;
  late String phone;
  late Market market;
  late List<Cart> purchases = [];
  late List<Product> favorites = [];
  late Cart cart;
  late List<int> scores = [];

  Person(this.firstname, this.lastname, this.phone, this.password);

  Person.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    market = Market.fromJson(json['market']);
    cart = Cart.fromJson(json['cart']);

    for (Map<String, dynamic> value in json['purchases']) {
      purchases.add(Cart.fromJson(value));
    }

    for (Map<String, dynamic> value in json['favorites']) {
      favorites.add(Product.fromJson(value));
    }

    List<dynamic> dynamicScores = json['scores'];
    for (var i in dynamicScores) {
      scores.add(i);
    }

    List<int> imageBytes = [];
    for (int i in json['image']) {
      imageBytes.add(i);
    }
    image = Uint8List.fromList(imageBytes);
  }

  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'password': password,
        'phone': phone,
        'market': market.name,
        'image': image?.toList(),
      };

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
