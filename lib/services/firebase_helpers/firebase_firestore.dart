part of '../firebase_service.dart';

class FirebaseFireStoreHelper {
  late final FirebaseFirestore _db;
  CollectionReference? _usersCollectionRef;
  CollectionReference? _restaurantsCollectionRef;
  CollectionReference? _menusCollectionRef;
  CollectionReference? _ordersRef;
  CollectionReference<RestaurantRatings>? _ratingsRef;

  FirebaseFireStoreHelper() {
    _db = FirebaseFirestore.instance;
    _usersCollectionRef = _db.collection(Collection.users);
    _restaurantsCollectionRef = _db.collection(Collection.restaurants);
    _menusCollectionRef = _db.collection(Collection.menus);
    _ordersRef = _db.collection(Collection.orders);

    _ratingsRef = _db.collection(Collection.ratings).withConverter(
          fromFirestore: RestaurantRatings.fromFirestore,
          toFirestore: (RestaurantRatings rating, options) =>
              rating.toFirestore(),
        );
  }

  DocumentReference userDocRef(String phoneNumber) {
    return _usersCollectionRef!.doc(phoneNumber);
  }

  Future<void> saveUserData(User? currentUser) async {
    if (_usersCollectionRef == null) return;
    if (currentUser == null) return;

    var userDoc = _usersCollectionRef?.doc(currentUser.phoneNumber);
    var docExists = false;

    try {
      await userDoc?.get().then((doc) => docExists = doc.exists);
    } catch (e) {
      docExists = false;
    }

    if (docExists) {
      await userDoc?.update({UserFields.uid: currentUser.uid});
    } else {
      await userDoc?.set({
        UserFields.uid: currentUser.uid,
        UserFields.phoneNumber: currentUser.phoneNumber,
      });
    }
  }

  Future<void> updateNewUserData() async {
    if (_usersCollectionRef == null) return;

    // Get current user uid
    final currentUser =
        FirebaseService.instance.firebaseAuthHelper.currentUser.value;
    if (currentUser == null) return;

    final userDoc = _usersCollectionRef?.doc(currentUser.phoneNumber);
    bool docExists = false;
    try {
      await userDoc?.get().then((doc) => docExists = doc.exists);
    } catch (e) {
      docExists = false;
    }
    if (!docExists) return;

    await userDoc?.update({
      UserFields.name: currentUser.displayName,
      UserFields.email: currentUser.email,
    });
  }

  Future<List?> get userFavData async {
    final currentUser =
        FirebaseService.instance.firebaseAuthHelper.currentUser.value;

    final doc = await _usersCollectionRef?.doc(currentUser?.phoneNumber).get();
    final data = doc?.data() as Map?;
    final favData = data?[UserFields.favRestaurants];

    return favData;
  }

  Future<bool> checkIsRestaurantFav(String restaurantId) async {
    final userFavorites = await userFavData;
    if (userFavorites != null) {
      return userFavorites.contains(restaurantId);
    }
    return false;
  }

  Future<void> addFavRestaurant(String restaurantId) async {
    var userFavorites = await userFavData;
    final currentUser =
        FirebaseService.instance.firebaseAuthHelper.currentUser.value;

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
    final currentUser =
        FirebaseService.instance.firebaseAuthHelper.currentUser.value;

    if (userFavorites != null) {
      userFavorites.remove(restaurantId);
      await _usersCollectionRef?.doc(currentUser?.phoneNumber).update({
        UserFields.favRestaurants: userFavorites,
      });
    }
  }

  Future<List<Restaurant>> _loadRestaurantsData({
    required bool inCampus,
  }) async {
    QuerySnapshot<Restaurant> snapshot = await _restaurantsCollectionRef!
        .withConverter(
          fromFirestore: Restaurant.fromFirestore,
          toFirestore: (restaurant, _) => restaurant.toFirestore(),
        )
        .where(RestaurantFields.inCampus, isEqualTo: inCampus)
        .orderBy(RestaurantFields.orderIndex)
        .get();
    final restaurantsData = snapshot.docs.map((e) {
      var resData = e.data();
      return resData;
    }).toList();
    return restaurantsData;
  }

  Future<List<Map<String, String?>>?> getInCampusDisplayResData() async {
    final restaurantsData = await _loadRestaurantsData(inCampus: true);
    List<Map<String, String?>> data = [];
    for (Restaurant res in restaurantsData) {
      data.add(res.shortData());
    }
    return data;
  }

  Future<List<Map<String, String?>>?> getNearCampusDisplayResData() async {
    final restaurantsData = await _loadRestaurantsData(inCampus: false);
    List<Map<String, String?>> data = [];
    for (Restaurant res in restaurantsData) {
      var rating = await restaurantRating(restaurantId: res.restaurantId);
      var subLocality = (await LocationService.instance.fetchPlacemark(
        latitude: res.geoLocation!.latitude,
        longitude: res.geoLocation!.longitude,
      ))
          .first
          .subLocality;

      var restData = res.shortData()
        ..update(
          RatingFields.rating,
          (_) => rating.toStringAsFixed(1),
          ifAbsent: () => rating.toStringAsFixed(1),
        )
        ..update(
          RestaurantFields.inAppSubLocality,
          (_) => subLocality,
          ifAbsent: () => subLocality,
        );
      data.add(restData);
    }
    return data;
  }

  Future<Restaurant?> getRestaurantData(String restaurantId) async {
    final resDocRef = _restaurantsCollectionRef!.doc(restaurantId);
    final data = await resDocRef
        .withConverter(
          fromFirestore: Restaurant.fromFirestore,
          toFirestore: (restaurant, _) => restaurant.toFirestore(),
        )
        .get();
    return data.data();
  }

  Future<Menu?> getMenuData(String restaurantId) async {
    final menuDocRef = _menusCollectionRef!.doc(restaurantId);
    final data = await menuDocRef
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

  DocumentReference<ZentroOrder> orderDocRef(String orderId) {
    return _ordersRef!
        .withConverter(
          fromFirestore: ZentroOrder.fromFirestore,
          toFirestore: (ZentroOrder order, options) => order.toFirestore(),
        )
        .doc(orderId);
  }

  Future<void> createOrder(ZentroOrder order) async {
    final docRef = orderDocRef(order.orderId);

    await docRef.set(order);
  }

  Future<void> updateOrder(ZentroOrder order) async {
    final docRef = orderDocRef(order.orderId);

    await docRef.update(order.toFirestore());
  }

  Future<ZentroOrder?> getOrder(String orderId) async {
    final orderSnapshot = await orderDocRef(orderId).get();
    return orderSnapshot.data();
  }

  Future<void> updateOrderStatus(OrderStatus status, [String? orderId]) async {
    var currentOrder =
        orderId == null ? await userCurrentOrder : await getOrder(orderId);
    if (currentOrder == null) return;

    final docRef = orderDocRef(currentOrder.orderId);
    await docRef.update({OrderFields.orderStatus: status.name});
  }

  Future<ZentroOrder?> get userCurrentOrder async {
    final currentUser =
        FirebaseService.instance.firebaseAuthHelper.currentUser.value;
    final userDoc =
        await _usersCollectionRef?.doc(currentUser?.phoneNumber).get();
    final userData = userDoc?.data() as Map?;
    final currentOrderId = userData?[UserFields.currentOrderId] as String?;
    if (currentOrderId == null) return null;
    return await getOrder(currentOrderId);
  }

  Future<List?> get userOrdersData async {
    final currentUser =
        FirebaseService.instance.firebaseAuthHelper.currentUser.value;

    final doc = await _usersCollectionRef?.doc(currentUser?.phoneNumber).get();
    final data = doc?.data() as Map?;
    final ordersData = data?[UserFields.orders];

    return ordersData;
  }

  Future<void> insertUsersOrder(String orderId) async {
    var userOrders = await userOrdersData;
    final currentUser =
        FirebaseService.instance.firebaseAuthHelper.currentUser.value;

    final userDocRef = _usersCollectionRef?.doc(currentUser?.phoneNumber);

    if (userOrders == null) {
      // Insert new order in list
      await userDocRef?.update({
        UserFields.orders: [orderId]
      });
    } else {
      // Update orders list
      userOrders.addIf(!userOrders.contains(orderId), orderId);
      await userDocRef?.update({UserFields.orders: userOrders});
    }
  }

  Future<void> updateUserCurrentOrder(
    String orderId, {
    bool remove = false,
  }) async {
    final currentUser =
        FirebaseService.instance.firebaseAuthHelper.currentUser.value;
    final userDocRef = _usersCollectionRef?.doc(currentUser?.phoneNumber);

    await userDocRef?.update({
      UserFields.currentOrderId: remove ? FieldValue.delete() : orderId,
    });
  }

  DocumentReference<RestaurantRatings> ratingDocRef(String ratingId) {
    return _ratingsRef!.doc(ratingId);
  }

  Future<bool> ratingExistsForOrder({required String orderId}) async {
    var snapshot = await _ratingsRef!
        .where(RatingFields.orderId, isEqualTo: orderId)
        .limit(1)
        .get();

    var data = snapshot.docs.map((e) => e.data());

    return data.isNotEmpty;
  }

  Future<void> createRating(RestaurantRatings rating) async {
    if (await ratingExistsForOrder(orderId: rating.orderId)) return;

    final docRef = ratingDocRef(rating.ratingId);

    await docRef.set(rating);
  }

  Future<double> restaurantRating({required String restaurantId}) async {
    final querySnapshot = await _ratingsRef!
        .where(RatingFields.restId, isEqualTo: restaurantId)
        .get();
    final ratings = querySnapshot.docs.map((e) => e.data().rating).toList();
    if (ratings.isEmpty) {
      return 0;
    } else {
      return ratings.reduce((a, b) => a + b) / ratings.length;
    }
  }
}
