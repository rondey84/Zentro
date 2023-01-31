import 'package:zentro/util/extensions/string_extension.dart';

class MenuItem {
  final String? name;
  final String? category;
  final String? description;
  final String? image;
  final List<String>? ingredients;
  final double? price;
  final bool isVeg;

  MenuItem({
    this.name,
    this.category,
    this.description,
    this.image,
    this.ingredients,
    this.price,
    this.isVeg = true,
  });

  factory MenuItem.fromMap(Map<String, dynamic> map) {
    var menuItem = MenuItem(
      name: map['name'],
      category: map['category'],
      description: map['description'],
      image: map['image'],
      ingredients:
          map['ingredients'] is Iterable ? List.from(map['ingredients']) : null,
      price: map['price'] is int
          ? (map['price'] as int).toDouble()
          : map['price'] is double
              ? map['price']
              : null,
      isVeg: map['veg'] is bool
          ? map['veg']
          : map['veg'] is String
              ? (map['veg'] as String).parseBool()
              : null,
    );
    return menuItem;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'description': description,
      'image': image,
      'ingredients': ingredients,
      'price': price,
      'veg': isVeg,
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
