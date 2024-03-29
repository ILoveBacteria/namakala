import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:namakala/utilities/market.dart';

class Product {
  late int id;
  late String name;
  late Uint8List image;
  late String detail;
  late int price;
  late String category;
  late Market market;
  late int count;
  double score = 0.0;
  late List<Color> color = [];
  late List<String> size = [];

  Product(this.name, this.image, this.price, this.category, this.detail,
      this.color, this.size, this.count, this.market, this.id);

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    detail = json['detail'];
    price = json['price'];
    category = json['category'];
    market = Market.fromJson(json['market']);
    count = json['count'];
    score = json['score'];

    List<dynamic> dynamicSizes = json['size'];
    for (var i in dynamicSizes) {
      size.add(i);
    }

    List<int> imageBytes = [];
    for (int i in json['image']) {
      imageBytes.add(i);
    }
    image = Uint8List.fromList(imageBytes);

    for (int value in json['color']) {
      color.add(Color(value));
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'category':category,
      };

  Map<String, dynamic> toJson2() => {
    'id': id,
    'category':category,
    'name': name,
    'detail': detail,
    'price': price,
    'market': market.name,
    'count': count,
    'size': size,
    'color': color.map((e) => e.value).toList(),
    'image': image.toList(),
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
