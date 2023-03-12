import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:objectbox/objectbox.dart';
import 'package:zentro/data/model/menu.dart';
import 'package:zentro/services/firebase_helpers/fs_db_helper.dart';
import 'package:zentro/util/extensions/string_extension.dart';

@Entity()
class MenuItem {
  @Id()
  int obId = 0;
  String id;
  String? name;
  String? category;
  String? description;
  String? image;
  List<String>? ingredients;
  double? price;
  double? tax;
  bool isVeg;
  int ratingsValue;
  int ratingsCount;

  final menu = ToOne<Menu>();

  MenuItem({
    required this.id,
    this.name,
    this.category,
    this.description,
    this.image,
    this.ingredients,
    this.price,
    this.tax,
    this.isVeg = true,
    this.ratingsValue = 0,
    this.ratingsCount = 0,
  });

  factory MenuItem.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    if (data != null) {
      return MenuItem.fromJson(data);
    }

    return MenuItem(id: '');
  }

  Map<String, dynamic> toJson() {
    return {
      MenuFields.menuItemId: id,
      MenuFields.menuItemName: name,
      MenuFields.menuItemCategory: category,
      MenuFields.menuItemDesc: description,
      MenuFields.menuItemImage: image,
      MenuFields.menuItemIngredients: ingredients,
      MenuFields.menuItemPrice: price,
      MenuFields.menuItemTax: tax,
      MenuFields.menuItemIsVeg: isVeg,
      'ratingsValue': ratingsValue,
      'ratingsCount': ratingsCount,
    };
  }

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    var menuItem = MenuItem(
      id: json[MenuFields.menuItemId],
      name: json[MenuFields.menuItemName],
      category: json[MenuFields.menuItemCategory],
      description: json[MenuFields.menuItemDesc],
      image: json[MenuFields.menuItemImage],
      ingredients: json[MenuFields.menuItemIngredients] is Iterable
          ? List.from(json[MenuFields.menuItemIngredients])
          : null,
      price: json[MenuFields.menuItemPrice] is int
          ? (json[MenuFields.menuItemPrice] as int).toDouble()
          : json[MenuFields.menuItemPrice] is double
              ? json[MenuFields.menuItemPrice]
              : null,
      tax: json[MenuFields.menuItemTax] is int
          ? (json[MenuFields.menuItemTax] as int).toDouble()
          : json[MenuFields.menuItemTax] is double
              ? json[MenuFields.menuItemTax]
              : null,
      isVeg: json[MenuFields.menuItemIsVeg] is bool
          ? json[MenuFields.menuItemIsVeg]
          : json[MenuFields.menuItemIsVeg] is String
              ? (json[MenuFields.menuItemIsVeg] as String).parseBool()
              : true,
      ratingsValue: json['ratingsValue'] ?? 0,
      ratingsCount: json['ratingsCount'] ?? 0,
    );
    return menuItem;
  }

  MenuItem copyWith({
    int? obId,
    String? id,
    String? name,
    String? category,
    String? description,
    String? image,
    List<String>? ingredients,
    double? price,
    double? tax,
    bool? isVeg,
    int? ratingsValue,
    int? ratingsCount,
    ToOne<Menu>? menu,
  }) {
    return MenuItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      image: image ?? this.image,
      ingredients: ingredients ?? this.ingredients,
      price: price ?? this.price,
      tax: tax ?? this.tax,
      isVeg: isVeg ?? this.isVeg,
      ratingsValue: ratingsValue ?? this.ratingsValue,
      ratingsCount: ratingsCount ?? this.ratingsCount,
    )
      ..obId = obId ?? this.obId
      ..menu.target = menu?.target ?? this.menu.target;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          category == other.category &&
          description == other.description &&
          image == other.image &&
          const ListEquality<String>().equals(ingredients, other.ingredients) &&
          price == other.price &&
          tax == other.tax &&
          isVeg == other.isVeg &&
          ratingsValue == other.ratingsValue &&
          ratingsCount == other.ratingsCount;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      category.hashCode ^
      description.hashCode ^
      image.hashCode ^
      price.hashCode ^
      tax.hashCode ^
      isVeg.hashCode;

  @override
  String toString() {
    return toJson().toString();
  }
}
