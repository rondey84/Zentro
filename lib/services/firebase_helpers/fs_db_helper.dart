/// Main Collection Names in Cloud Firestore
abstract class Collection {
  static const restaurants = 'restaurants';
  static const menus = 'menus';
  static const users = 'users';
}

/// Firestore Users Data fields name
abstract class UserFields {
  static const collectionName = Collection.users;

  static const email = 'email';
  static const name = 'name';
  static const phoneNumber = 'phoneNumber';
  static const uid = 'uid';
  static const favRestaurants = 'favoriteRestaurants';
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
