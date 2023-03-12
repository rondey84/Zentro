import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:objectbox/objectbox.dart';
import 'package:zentro/data/model/menu_item.dart';
import 'package:zentro/services/firebase_helpers/fs_db_helper.dart';
import './restaurant.dart';

@Entity()
class Menu {
  @Id()
  int obId = 0;
  String restId;
  List<String>? categories;
  List<String>? recommended;

  final restaurant = ToOne<Restaurant>();
  @Backlink('menu')
  final menuItems = ToMany<MenuItem>();

  Menu({
    required this.restId,
    this.categories,
    this.recommended,
  });

  factory Menu.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Menu(
      restId: data?[MenuFields.restaurantId],
      categories: data?[MenuFields.categories] is Iterable
          ? List.from(data?[MenuFields.categories])
          : null,
      recommended: data?[MenuFields.recommended] is Iterable
          ? List.from(data?[MenuFields.recommended])
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      MenuFields.restaurantId: restId,
      if (categories != null) MenuFields.categories: categories,
      if (recommended != null) MenuFields.recommended: recommended,
    };
  }

  Menu copyWith({
    int? obId,
    String? restId,
    List<String>? categories,
    List<String>? recommended,
    ToOne<Restaurant>? restaurant,
    List<MenuItem>? menuItems,
  }) {
    return Menu(
      restId: restId ?? this.restId,
      categories: categories ?? this.categories,
      recommended: recommended ?? this.recommended,
    )
      ..obId = obId ?? this.obId
      ..restaurant.target = restaurant?.target ?? this.restaurant.target
      ..menuItems.clear()
      ..menuItems.addAll(menuItems ?? this.menuItems.toList());
  }

  @override
  String toString() {
    return '{restaurantId: $restId, categories: $categories, recommended: $recommended}';
  }
}
