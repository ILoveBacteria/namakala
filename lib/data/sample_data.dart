import 'package:flutter/material.dart';

import '../utilities/market.dart';
import '../utilities/person.dart';
import '../utilities/product.dart';

class SampleData {
  static Person person = Person('Moein', 'Arabi', 'abc1234', '0123456789');

  static final Map<Product, int> products = <Product, int>{
    Product(
      'iPhone 13 pro max',
      'assets/images/iphone.png',
      999,
      'Mobiles',
      'This product is in Test!',
      [Colors.blue, Colors.yellow],
      ['128GB', '256GB', '512GB'],
      Market(SampleData.person, 'Digikala'),
    ): 3,
    Product(
      'iPhone 13',
      'assets/images/iphone13.png',
      899,
      'Mobiles',
      'This product is in Test!',
      [Colors.blue, Colors.black],
      ['128GB', '256GB'],
      Market(SampleData.person, 'Digikala'),
    ): 2,
    Product(
      'iPhone 13 pro',
      'assets/images/iphone.png',
      999,
      'Mobiles',
      'This product is in Test!',
      [Colors.pink, Colors.green],
      ['128GB', '256GB'],
      Market(SampleData.person, 'Digikala'),
    ): 1,
    Product(
      'iPhone 13 mini',
      'assets/images/iphone13.png',
      899,
      'Mobiles',
      'This product is in Test!',
      [Colors.blue],
      ['128GB', '256GB'],
      Market(SampleData.person, 'Digikala'),
    ): 0,
    Product(
      'Macbook Air',
      'assets/images/macbook.png',
      999,
      'Laptops',
      'This product is in Test!',
      [Colors.grey],
      ['default'],
      Market(SampleData.person, 'Digikala'),
    ): 3,
    Product(
      'MacBook Pro M1',
      'assets/images/macbook.png',
      1199,
      'Laptops',
      'This product is in Test!',
      [Colors.grey],
      ['default'],
      Market(SampleData.person, 'Digikala'),
    ): 2,
  };
}
