import 'cart.dart';
import 'person.dart';
import 'product.dart';

class Arguments {
  Person? person;
  Product? product;
  String? category;
  Cart? cart;

  Arguments(this.person, this.product);

  Arguments.favoriteCategory(this.person, this.category);

  Arguments.category(this.category);

  Arguments.person(this.person);

  Arguments.all(this.person, this.product, this.category);

  Arguments.cart(this.person, this.cart);
}