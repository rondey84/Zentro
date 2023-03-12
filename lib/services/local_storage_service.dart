import 'package:get/get.dart';
import 'package:zentro/data/model/appdata.dart';
import 'package:zentro/data/model/menu.dart';
import 'package:zentro/data/model/menu_item.dart';
import 'package:zentro/data/model/restaurant.dart';
import 'package:zentro/data/model/user_models.dart' as user_model;
import 'package:zentro/util/object_box.dart';

class LocalStorageService extends GetxService {
  late ObjectBox _box;
  late AppData appData;

  // TODO: TESTING GETTER for easy access to ObjectBox, REMOVE AFTER TESTING
  ObjectBox get box => _box;

  Future<LocalStorageService> init() async {
    _box = await ObjectBox.create();
    storageSetup();
    return this;
  }

  void storageSetup() {
    if (_box.appDataBox.isEmpty()) {
      appData = AppData();
      _box.insertAppData(appData);
    } else {
      appData = _box.appDataBox.getAll()[0];
    }
  }

  void setOnBoardingStatus() {
    appData.onBoardComplete = true;
    _box.insertAppData(appData);
  }

  user_model.User? getUserDataOrNull(String phoneNumber) {
    return _box.getUserDataOrNull(phoneNumber);
  }

  user_model.User getUserData() => _box.getUserData();

  void insertUserData(user_model.User user, {bool noDuplicateCheck = false}) {
    if (noDuplicateCheck) {
      _box.insertUserData(user);
      return;
    }
    var userData = getUserDataOrNull(user.phoneNumber);
    userData = userData?.copyWith(
          phoneNumber: user.phoneNumber,
          uid: user.uid,
          name: user.name,
          email: user.email,
          isEmailVerified: user.isEmailVerified,
          favRestaurants: user.favRestaurants,
          cart: user.cart,
        ) ??
        user;
    _box.insertUserData(user);
  }

  void deleteUserData() => _box.deleteUserData();

  bool? checkIsRestaurantFav(String restaurantId) {
    var favResData = getUserData().favRestaurants;
    if (favResData.isEmpty) return null;

    return favResData.contains(restaurantId);
  }

  Restaurant? getRestaurantData(String restaurantId) {
    return _box.getRestaurantData(restaurantId);
  }

  void insertRestaurantData(Restaurant res, {bool noDuplicateCheck = false}) {
    if (noDuplicateCheck) {
      _box.insertRestaurantData(res);
      return;
    }

    var restaurant = _box.getRestaurantData(res.restaurantId);

    restaurant = restaurant?.copyWith(
          name: res.name,
          shortDescription: res.shortDescription,
          longDescription: res.longDescription,
          image: res.image,
          geoLocation: res.geoLocation,
          address: res.address,
        ) ??
        res;

    _box.insertRestaurantData(restaurant);
  }

  Menu? getMenuData(String restaurantId) {
    return _box.getMenuData(restaurantId);
  }

  void insertMenuData({
    required String restaurantId,
    required Menu menu,
    bool noDuplicateCheck = false,
  }) {
    if (noDuplicateCheck) {
      _box.insertMenuData(restaurantId, menu);
      return;
    }

    var menuData = _box.getMenuData(restaurantId);
    menuData = menuData?.copyWith(
          restId: menu.restId,
          categories: menu.categories,
          recommended: menu.recommended,
        ) ??
        menu;
    _box.insertMenuData(restaurantId, menuData);
  }

  void removeMenuData({required Menu menu}) {
    _box.removeMenuData(menu);
  }

  MenuItem? getMenuItemData(String restaurantId, String menuItemId) {
    return _box.getMenuItemData(restaurantId, menuItemId);
  }

  void insertOneMenuItemData({
    required String restaurantId,
    required MenuItem menuItem,
    bool noDuplicateCheck = false,
  }) {
    if (noDuplicateCheck) {
      _box.insertMenuItemData(restaurantId, menuItem);
      return;
    }

    var menuItemData = _box.getMenuItemData(restaurantId, menuItem.id);
    menuItemData = menuItemData?.copyWith(
          id: menuItem.id,
          name: menuItem.name,
          category: menuItem.category,
          description: menuItem.description,
          image: menuItem.image,
          ingredients: menuItem.ingredients,
          price: menuItem.price,
          tax: menuItem.tax,
          isVeg: menuItem.isVeg,
          ratingsValue: menuItem.ratingsValue,
          ratingsCount: menuItem.ratingsCount,
        ) ??
        menuItem;
    _box.insertMenuItemData(restaurantId, menuItemData);
  }

  void removeOneMenuItemData(String restaurantId, MenuItem menuItem) {
    _box.deleteMenuItemData(restaurantId, menuItem);
  }

  void insertManyMenuItemsData({
    required String restaurantId,
    required List<MenuItem> menuItems,
    bool noDuplicateCheck = false,
  }) {
    if (noDuplicateCheck) {
      _box.insertMenuItemsData(restaurantId, menuItems);
      return;
    }

    List<MenuItem>? menuItemsData = [];
    for (var menuItem in menuItems) {
      var menuItemData = _box.getMenuItemData(restaurantId, menuItem.id);
      menuItemData = menuItemData?.copyWith(
            id: menuItem.id,
            name: menuItem.name,
            category: menuItem.category,
            description: menuItem.description,
            image: menuItem.image,
            ingredients: menuItem.ingredients,
            price: menuItem.price,
            tax: menuItem.tax,
            isVeg: menuItem.isVeg,
            ratingsValue: menuItem.ratingsValue,
            ratingsCount: menuItem.ratingsCount,
          ) ??
          menuItem;
      menuItemsData.add(menuItemData);
    }
    _box.insertMenuItemsData(restaurantId, menuItemsData);
  }

  void removeManyMenuItemsData(String restaurantId) {
    _box.deleteMenuItemsData(restaurantId);
  }
}
