import 'package:cloud_firestore/cloud_firestore.dart';
import './menu_item.dart';

class Restaurant {
  String? id;
  final String? name;
  final String? description;
  final String? image;
  final GeoPoint? geoLocation;
  final String? address;
  final List<MenuItem>? menu;

  Restaurant({
    this.id,
    required this.name,
    this.description,
    this.image,
    this.geoLocation,
    this.address,
    this.menu = const [],
  });

  factory Restaurant.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Restaurant(
      name: data?['name'],
      description: data?['description'],
      image: data?['image'],
      geoLocation: data?['geo_location'],
      address: data?['location'],
      menu: data?['menu'] is Iterable
          ? List.from(data?['menu'])
              .map((item) => MenuItem.fromMap(item))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (description != null) "description": description,
      if (image != null) "image": image,
      if (geoLocation != null) "geoLocation": geoLocation,
      if (address != null) "address": address,
      if (menu != null) "menu": menu,
    };
  }

  Map<String, String?> homeDisplayData() {
    return {
      if (id != null) 'id': id,
      if (name != null) "name": name,
      if (image != null) "image": image,
    };
  }

  @override
  String toString() {
    return 'name: $name, description: $description, image: $image, geoLocation: (${geoLocation?.latitude}, ${geoLocation?.latitude}), address: $address, menu: ${menu.toString()}';
  }
}
