import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:objectbox/objectbox.dart';
import 'package:zentro/services/firebase_helpers/fs_db_helper.dart';

@Entity()
class Restaurant {
  @Id()
  int obId = 0;
  String restaurantId;
  String? name;
  String? shortDescription;
  String? longDescription;
  String? image;
  @Transient()
  GeoPoint? geoLocation;
  String? address;
  bool insideCampus;
  int orderIndex;
  List<String>? outlets;
  String? selectedOutlet;

  String? imageUrl;
  String? cachedImagePath;

  List<double?>? get dbGeoLocation {
    return [geoLocation?.latitude, geoLocation?.longitude];
  }

  set dbGeoLocation(List<double?>? val) {
    if (val == null) {
      geoLocation = null;
    } else {
      geoLocation = GeoPoint(val[0] ?? 0.0, val[1] ?? 0.0);
    }
  }

  Restaurant({
    required this.restaurantId,
    required this.name,
    this.shortDescription,
    this.longDescription,
    this.image,
    this.geoLocation,
    this.address,
    this.imageUrl,
    this.cachedImagePath,
    this.insideCampus = false,
    this.orderIndex = 0,
    this.outlets,
    this.selectedOutlet,
  });

  factory Restaurant.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Restaurant(
      restaurantId: data?[RestaurantFields.id],
      name: data?[RestaurantFields.name],
      shortDescription: data?[RestaurantFields.shortDes],
      longDescription: data?[RestaurantFields.longDes],
      image: data?[RestaurantFields.image],
      geoLocation: data?[RestaurantFields.geoLocation] as GeoPoint?,
      address: data?[RestaurantFields.address],
      insideCampus: data?[RestaurantFields.inCampus],
      orderIndex: data?[RestaurantFields.orderIndex],
      outlets: data?[RestaurantFields.outlets] is Iterable
          ? List.from(data?[RestaurantFields.outlets] ?? [])
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      RestaurantFields.id: restaurantId,
      if (name != null) RestaurantFields.name: name,
      if (shortDescription != null) RestaurantFields.shortDes: shortDescription,
      if (longDescription != null) RestaurantFields.longDes: longDescription,
      if (image != null) RestaurantFields.image: image,
      if (geoLocation != null) RestaurantFields.geoLocation: geoLocation,
      if (address != null) RestaurantFields.address: address,
      RestaurantFields.inCampus: insideCampus,
      RestaurantFields.orderIndex: orderIndex,
    };
  }

  Map<String, String?> shortData() {
    return {
      RestaurantFields.id: restaurantId,
      if (name != null) RestaurantFields.name: name,
      if (image != null) RestaurantFields.image: image,
    };
  }

  Restaurant copyWith({
    int? obId,
    String? restaurantId,
    String? name,
    String? shortDescription,
    String? longDescription,
    String? image,
    GeoPoint? geoLocation,
    String? address,
    String? imageUrl,
    String? cachedImagePath,
    bool? insideCampus,
    int? orderIndex,
    List<String>? outlets,
    String? selectedOutlet,
  }) {
    return Restaurant(
      restaurantId: restaurantId ?? this.restaurantId,
      name: name ?? this.name,
      shortDescription: shortDescription ?? this.shortDescription,
      longDescription: longDescription ?? this.longDescription,
      image: image ?? this.image,
      geoLocation: geoLocation ?? this.geoLocation,
      address: address ?? this.address,
      imageUrl: imageUrl ?? this.imageUrl,
      cachedImagePath: cachedImagePath ?? this.cachedImagePath,
      insideCampus: insideCampus ?? this.insideCampus,
      orderIndex: orderIndex ?? this.orderIndex,
      outlets: outlets ?? this.outlets,
      selectedOutlet: selectedOutlet ?? this.selectedOutlet,
    )..obId = obId ?? this.obId;
  }

  @override
  String toString() {
    var map = {
      'id': restaurantId,
      'name': name,
      'short description': shortDescription,
      'long description': longDescription,
      'image': image,
      'geoLocation': [geoLocation?.latitude, geoLocation?.latitude],
      'location': address,
      'imageUrl': imageUrl,
      'cachedImagePath': cachedImagePath,
      'insideCampus': insideCampus,
      'orderIndex': orderIndex,
      'outlets': outlets,
      'selectedOutlet': selectedOutlet,
    };
    return map.toString();
  }
}
