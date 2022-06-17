import 'package:flutter/material.dart';
import 'package:namakala/utilities/market.dart';

class Product {
  late double id;
  late String name;
  late String image;
  late String detail;
  late int price;
  late String category;
  late Market market;
  int? count;
  double score = 0;
  int _countVoters = 0;
  late List<Color> color;
  late List<String> size;

  Product(this.name, this.image, this.price, this.category, this.detail,
      this.color, this.size, this.market);

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    detail = json['detail'];
    price = json['price'];
    category = json['category'];
    market = Market.fromJson(json['market']);
    size = json['size'];

    for (int value in json['color']) {
      color.add(Color(value));
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          image == other.image &&
          price == other.price &&
          category == other.category &&
          market == other.market &&
          color == other.color &&
          size == other.size;

  @override
  int get hashCode =>
      name.hashCode ^
      image.hashCode ^
      price.hashCode ^
      category.hashCode ^
      market.hashCode ^
      color.hashCode ^
      size.hashCode;
}
