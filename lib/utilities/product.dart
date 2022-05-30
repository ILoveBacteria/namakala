import 'package:namakala/utilities/market.dart';

class Product {
  String name;
  String image;
  String detail;
  int price;
  String category;
  Market? market;
  int? count;
  double score = 0;
  int _countVoters = 0;

  static final List<Product> mobileProducts = <Product>[
    Product('iPhone 13 pro max - 512Gb', 'assets/images/iphone.png', 999, 'Mobiles', 'This product is in Test!'),
    Product('iPhone 13 - 256Gb', 'assets/images/iphone13.png', 899, 'Mobiles', 'This product is in Test!'),
    Product('iPhone 13 pro max - 512Gb', 'assets/images/iphone.png', 999, 'Mobiles', 'This product is in Test!'),
    Product('iPhone 13 - 256Gb', 'assets/images/iphone13.png', 899, 'Mobiles', 'This product is in Test!'),
    Product('iPhone 13 pro max - 512Gb', 'assets/images/iphone.png', 999, 'Mobiles', 'This product is in Test!'),
  ];

  static final List<Product> laptopProducts = <Product>[
    Product('Macbook Air', 'assets/images/macbook.png', 999, 'Laptops', 'This product is in Test!'),
    Product('MacBook Pro M1', 'assets/images/macbook.png', 1199, 'Laptops', 'This product is in Test!'),
    Product('Macbook Air', 'assets/images/macbook.png', 999, 'Laptops', 'This product is in Test!'),
    Product('MacBook Pro M1', 'assets/images/macbook.png', 1199, 'Laptops', 'This product is in Test!'),
  ];

  Product(this.name, this.image, this.price, this.category, this.detail);

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