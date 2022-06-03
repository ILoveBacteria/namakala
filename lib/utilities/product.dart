import 'package:flutter/material.dart';
import 'package:namakala/data/sample_data.dart';
import 'package:namakala/utilities/market.dart';
import 'package:namakala/utilities/person.dart';

class Product {
  String name;
  String image;
  String detail;
  int price;
  String category;
  Market market;
  int? count;
  double score = 0;
  int _countVoters = 0;
  List<Color> color = [];
  List<String> size = [];

  Product(this.name, this.image, this.price, this.category, this.detail,
      this.color, this.market);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          image == other.image &&
          price == other.price &&
          category == other.category &&
          market == other.market;

  @override
  int get hashCode =>
      name.hashCode ^
      image.hashCode ^
      price.hashCode ^
      category.hashCode ^
      market.hashCode;
}
