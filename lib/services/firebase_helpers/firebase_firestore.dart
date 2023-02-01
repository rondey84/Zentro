part of '../firebase_service.dart';

class FirebaseFireStoreHelper {
  late final FirebaseFirestore _db;
  CollectionReference? _restaurantsCollectionRef;
  List<Restaurant>? restaurantsData;

  FirebaseFireStoreHelper() {
    _db = FirebaseFirestore.instance;
    _restaurantsCollectionRef = _db.collection('restaurants');
  }

  Future<void> _loadRestaurantData() async {
    if (_restaurantsCollectionRef == null) return;
    QuerySnapshot<Restaurant> snapshot = await _restaurantsCollectionRef!
        .withConverter(
          fromFirestore: Restaurant.fromFirestore,
          toFirestore: (restaurant, _) => restaurant.toFirestore(),
        )
        .get();

    restaurantsData = snapshot.docs.map((e) {
      var resData = e.data();
      resData.id = e.id;
      return resData;
    }).toList();
  }

  Future<List<Map<String, String?>>?> getAllDisplayResData() async {
    if (restaurantsData == null) await _loadRestaurantData();
    List<Map<String, String?>> data = [];

    for (Restaurant res in restaurantsData!) {
      data.add(res.homeDisplayData());
    }

    return data;
  }
}
