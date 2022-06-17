import 'package:flutter/material.dart';
import 'package:namakala/utilities/product.dart';

class SelectedProduct {
  Product product;
  Color color;
  String size;

  SelectedProduct(this.product, this.color, this.size);

  SelectedProduct.fromJson(Map<String, dynamic> json)
      : product = Product.fromJson(json['product']),
        color = Color(json['color']),
        size = json['size'];

  Map<String, dynamic> toJson() => {
        'product': product.toJson(),
        'color': color.value,
        'size': size,
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
