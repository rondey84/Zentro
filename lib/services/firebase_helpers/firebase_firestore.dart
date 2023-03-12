part of '../firebase_service.dart';

class FirebaseFireStoreHelper {
  late final FirebaseFirestore _db;
  CollectionReference? _usersCollectionRef;
  CollectionReference? _restaurantsCollectionRef;
  CollectionReference? _menusCollectionRef;

  FirebaseFireStoreHelper() {
    _db = FirebaseFirestore.instance;
    _usersCollectionRef = _db.collection(Collection.users);
    _restaurantsCollectionRef = _db.collection(Collection.restaurants);
    _menusCollectionRef = _db.collection(Collection.menus);
  }

  FirebaseService get firebaseService => Get.find<FirebaseService>();

  Future<void> saveUserData(User? currentUser) async {
    if (_usersCollectionRef == null) return;
    if (currentUser == null) return;

    var doc = _usersCollectionRef?.doc(currentUser.phoneNumber);
    var docExists = false;

    try {
      await doc?.get().then((doc) => docExists = doc.exists);
    } catch (e) {
      docExists = false;
    }

    if (docExists) {
      await doc?.update({UserFields.uid: currentUser.uid});
    } else {
      await doc?.set({
        UserFields.uid: currentUser.uid,
        UserFields.phoneNumber: currentUser.phoneNumber,
      });
    }
  }

  Future<void> updateNewUserData() async {
    if (_usersCollectionRef == null) return;

    // Get current user uid
    var currentUser = firebaseService.firebaseAuthHelper.currentUser.value;
    if (currentUser == null) return;

    var doc = _usersCollectionRef?.doc(currentUser.phoneNumber);
    var docExists = false;
    try {
      await doc?.get().then((doc) => docExists = doc.exists);
    } catch (e) {
      docExists = false;
    }
    if (!docExists) return;

    await _usersCollectionRef?.doc(currentUser.phoneNumber).update({
      UserFields.name: currentUser.displayName,
      UserFields.email: currentUser.email,
    });
  }

  Future<List?> get userFavData async {
    var currentUser = firebaseService.firebaseAuthHelper.currentUser.value;

    var doc = await _usersCollectionRef?.doc(currentUser?.phoneNumber).get();
    var data = doc?.data() as Map?;
    var favData = data?[UserFields.favRestaurants];

    return favData;
  }

  Future<bool> checkIsRestaurantFav(String restaurantId) async {
    var userFavorites = await userFavData;
    if (userFavorites != null) {
      return userFavorites.contains(restaurantId);
    }
    return false;
  }

  Future<void> addFavRestaurant(String restaurantId) async {
    var userFavorites = await userFavData;
    var currentUser = firebaseService.firebaseAuthHelper.currentUser.value;

    if (userFavorites == null) {
      // Insert new fav list
      await _usersCollectionRef?.doc(currentUser?.phoneNumber).update({
        UserFields.favRestaurants: [restaurantId],
      });
    } else {
      // Update fav list
      userFavorites.addIf(!userFavorites.contains(restaurantId), restaurantId);
      await _usersCollectionRef?.doc(currentUser?.phoneNumber).update({
        UserFields.favRestaurants: userFavorites,
      });
    }
  }

  Future<void> removeFavRestaurant(String restaurantId) async {
    var userFavorites = await userFavData;
    var currentUser = firebaseService.firebaseAuthHelper.currentUser.value;

    if (userFavorites != null) {
      userFavorites.remove(restaurantId);
      await _usersCollectionRef?.doc(currentUser?.phoneNumber).update({
        UserFields.favRestaurants: userFavorites,
      });
    }
  }

  Future<List<Restaurant>> _loadRestaurantsData() async {
    QuerySnapshot<Restaurant> snapshot = await _restaurantsCollectionRef!
        .withConverter(
          fromFirestore: Restaurant.fromFirestore,
          toFirestore: (restaurant, _) => restaurant.toFirestore(),
        )
        .get();
    var restaurantsData = snapshot.docs.map((e) {
      var resData = e.data();
      return resData;
    }).toList();
    return restaurantsData;
  }

  Future<List<Map<String, String?>>?> getAllDisplayResData() async {
    var restaurantsData = await _loadRestaurantsData();
    List<Map<String, String?>> data = [];
    for (Restaurant res in restaurantsData) {
      data.add(res.shortData());
    }
    return data;
  }

  Future<Restaurant?> getRestaurantData(String restaurantId) async {
    final resDocRef = _restaurantsCollectionRef!.doc(restaurantId);
    var data = await resDocRef
        .withConverter(
          fromFirestore: Restaurant.fromFirestore,
          toFirestore: (restaurant, _) => restaurant.toFirestore(),
        )
        .get();
    return data.data();
  }

  Future<Menu?> getMenuData(String restaurantId) async {
    final menuDocRef = _menusCollectionRef!.doc(restaurantId);
    var data = await menuDocRef
        .withConverter(
          fromFirestore: Menu.fromFirestore,
          toFirestore: (menu, _) => menu.toFirestore(),
        )
        .get();
    return data.data();
  }

  Future<List<MenuItem>> getMenuItemsData({
    required String restaurantId,
    required String menuCategory,
  }) async {
    QuerySnapshot<MenuItem> snapshot = await _menusCollectionRef!
        .doc(restaurantId)
        .collection(menuCategory)
        .withConverter(
          fromFirestore: MenuItem.fromFirestore,
          toFirestore: (menuItem, _) => menuItem.toJson(),
        )
        .get();

    return snapshot.docs.map((e) => e.data()).toList();
  }
}
