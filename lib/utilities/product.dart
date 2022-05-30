class Product {
  String name;
  String image;
  int price;
  String category;

  static final List<Product> mobileProducts = <Product>[
    Product('iPhone 13 pro max - 512Gb', 'assets/images/iphone.png', 999, 'Mobiles'),
    Product('iPhone 13 - 256Gb', 'assets/images/iphone13.png', 899, 'Mobiles'),
    Product('iPhone 13 pro max - 512Gb', 'assets/images/iphone.png', 999, 'Mobiles'),
    Product('iPhone 13 - 256Gb', 'assets/images/iphone13.png', 899, 'Mobiles'),
    Product('iPhone 13 pro max - 512Gb', 'assets/images/iphone.png', 999, 'Mobiles'),
  ];

  Product(this.name, this.image, this.price, this.category);
}