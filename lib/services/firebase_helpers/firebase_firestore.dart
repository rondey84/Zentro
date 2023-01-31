part of '../firebase_service.dart';

class FirebaseFireStoreHelper {
  late final FirebaseFirestore _db;
  CollectionReference? _restaurantsCollectionRef;
  List<Restaurant>? restaurantsData;

  FirebaseFireStoreHelper._init() {
    _db = FirebaseFirestore.instance;
    _restaurantsCollectionRef = _db.collection('restaurants');
  }

  static Future<FirebaseFireStoreHelper> init() async {
    var dbHelper = FirebaseFireStoreHelper._init();
    await dbHelper._loadRestaurantData();
    return dbHelper;
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

  List<Map<String, String?>>? getAllDisplayResData() {
    if (restaurantsData == null) return null;
    List<Map<String, String?>> data = [];

    for (Restaurant res in restaurantsData!) {
      data.add(res.homeDisplayData());
    }

    return data;
  }
}
