import 'person.dart';
import 'product.dart';

class Arguments {
  Person? person;
  Product? product;
  String? category;

  Arguments(this.person, this.product);

  Arguments.favoriteCategory(this.person, this.category);

  Arguments.category(this.category);

  Arguments.person(this.person);
}