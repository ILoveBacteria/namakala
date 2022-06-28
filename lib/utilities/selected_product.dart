import 'package:flutter/material.dart';
import 'package:namakala/utilities/product.dart';

class SelectedProduct {
  Product product;
  Color color;
  String size;
  int count;

  SelectedProduct(this.product, this.color, this.size, this.count);

  SelectedProduct.fromJson(Map<String, dynamic> json)
      : product = Product.fromJson(json['product']),
        color = Color(json['color']),
        size = json['size'],
        count = json['count'];

  Map<String, dynamic> toJson() => {
        'product': product.toJson(),
        'color': color.value,
        'size': size,
        'count': count,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectedProduct &&
          runtimeType == other.runtimeType &&
          product == other.product &&
          color == other.color &&
          size == other.size;

  @override
  int get hashCode => product.hashCode ^ color.hashCode ^ size.hashCode;
}
