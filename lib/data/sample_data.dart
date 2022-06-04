import 'package:flutter/material.dart';

import '../utilities/market.dart';
import '../utilities/person.dart';
import '../utilities/product.dart';

class SampleData {
  static Person person = Person('Moein', 'Arabi', 'abc1234', '0123456789');

  static final List<Product> mobileProducts = <Product>[
    Product(
      'iPhone 13 pro max - 512Gb',
      'assets/images/iphone.png',
      999,
      'Mobiles',
      'This product is in Test!',
      [Colors.blue, Colors.yellow],
      Market(SampleData.person, 'Digikala'),
    ),
    Product(
      'iPhone 13 - 256Gb',
      'assets/images/iphone13.png',
      899,
      'Mobiles',
      'This product is in Test!',
      [Colors.blue],
      Market(SampleData.person, 'Digikala'),
    ),
    Product(
      'iPhone 13 pro max - 512Gb',
      'assets/images/iphone.png',
      999,
      'Mobiles',
      'This product is in Test!',
      [Colors.blue],
      Market(SampleData.person, 'Digikala'),
    ),
    Product(
      'iPhone 13 - 256Gb',
      'assets/images/iphone13.png',
      899,
      'Mobiles',
      'This product is in Test!',
      [Colors.blue],
      Market(SampleData.person, 'Digikala'),
    ),
    Product(
      'iPhone 13 pro max - 512Gb',
      'assets/images/iphone.png',
      999,
      'Mobiles',
      'This product is in Test!',
      [Colors.blue],
      Market(SampleData.person, 'Digikala'),
    ),
  ];

  static final List<Product> laptopProducts = <Product>[
    Product(
      'Macbook Air',
      'assets/images/macbook.png',
      999,
      'Laptops',
      'This product is in Test!',
      [Colors.blue],
      Market(SampleData.person, 'Digikala'),
    ),
    Product(
      'MacBook Pro M1',
      'assets/images/macbook.png',
      1199,
      'Laptops',
      'This product is in Test!',
      [Colors.blue],
      Market(SampleData.person, 'Digikala'),
    ),
    Product(
      'Macbook Air',
      'assets/images/macbook.png',
      999,
      'Laptops',
      'This product is in Test!',
      [Colors.blue],
      Market(SampleData.person, 'Digikala'),
    ),
    Product(
      'MacBook Pro M1',
      'assets/images/macbook.png',
      1199,
      'Laptops',
      'This product is in Test!',
      [Colors.blue],
      Market(SampleData.person, 'Digikala'),
    ),
  ];
}
