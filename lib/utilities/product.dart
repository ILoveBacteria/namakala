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

  static final List<Product> laptopProducts = <Product>[
    Product('Macbook Air', 'assets/images/macbook.png', 999, 'Laptops'),
    Product('MacBook Pro M1', 'assets/images/macbook.png', 1199, 'Laptops'),
    Product('Macbook Air', 'assets/images/macbook.png', 999, 'Laptops'),
    Product('MacBook Pro M1', 'assets/images/macbook.png', 1199, 'Laptops'),
  ];

  Product(this.name, this.image, this.price, this.category);
}