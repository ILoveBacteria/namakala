class Product {
  String _name;
  String _image;
  double _price;

  Product(this._name, this._image, this._price);

  double get price => _price;

  String get image => _image;

  String get name => _name;

  set price(double value) {
    _price = value;
  }

  set image(String value) {
    _image = value;
  }

  set name(String value) {
    _name = value;
  }
}