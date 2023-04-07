/// Main Collection Names in Cloud Firestore
abstract class Collection {
  static const restaurants = 'restaurants';
  static const menus = 'menus';
  static const users = 'users';
  static const orders = 'orders';
  static const ratings = 'ratings';
}

/// Firestore Users Data fields name
abstract class UserFields {
  static const collectionName = Collection.users;

  static const email = 'email';
  static const name = 'name';
  static const phoneNumber = 'phoneNumber';
  static const uid = 'uid';
  static const favRestaurants = 'favoriteRestaurants';
  static const orders = 'orders';
  static const currentOrderId = 'currentOrderId';
}

/// Firestore Restaurant Data fields name
abstract class RestaurantFields {
  static const collectionName = Collection.restaurants;

  static const id = 'id';
  static const name = 'name';
  static const shortDes = 'short_description';
  static const longDes = 'long_description';
  static const image = 'image';
  static const geoLocation = 'geo_location';
  static const address = 'location';
  static const inCampus = 'inside_campus';
  static const orderIndex = 'order_index';
  static const outlets = 'outlets';

  // In App fields
  static const inAppSubLocality = 'local-subLocality';
}

/// Firestore Menu and Menu Items Data fields name
abstract class MenuFields {
  static const collectionName = Collection.menus;

  static const restaurantId = 'restaurantId';
  static const categories = 'categories';
  static const recommended = 'recommended';

  static const menuItemId = 'id';
  static const menuItemName = 'name';
  static const menuItemCategory = 'category';
  static const menuItemDesc = 'description';
  static const menuItemImage = 'image';
  static const menuItemIngredients = 'ingredients';
  static const menuItemPrice = 'price';
  static const menuItemTax = 'tax';
  static const menuItemIsVeg = 'veg';
}

abstract class OrderFields {
  static const collectionName = Collection.orders;

  static const orderId = 'id';
  static const paymentType = 'paymentType';
  static const orderStatus = 'status';
  static const createdAt = 'createdAt';
  static const userRef = 'user';
  static const restId = 'restaurantId';
  static const items = 'items';
  static const price = 'price';
  static const isPaid = 'isPaid';
  static const ratingId = 'ratingId';
  static const outlet = 'outlet';
}

abstract class RatingFields {
  static const collectionName = Collection.ratings;

  static const ratingId = 'id';
  static const orderId = 'orderId';
  static const userId = 'userId';
  static const restId = 'restId';
  static const rating = 'rating';
  static const feedback = 'feedback';
  static const createdAt = 'createdAt';
}
