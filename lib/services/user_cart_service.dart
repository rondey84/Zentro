import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:zentro/data/model/menu.dart';
import 'package:zentro/data/model/menu_item.dart';
import 'package:zentro/data/model/restaurant.dart';
import 'package:zentro/data/model/user_models.dart' as user_model;
import 'package:zentro/services/local_storage_service.dart';

class UserCartService extends GetxService {
  // Instance of this Service
  static final instance = Get.find<UserCartService>();

  final _localStorageService = LocalStorageService.instance;

  // Getters
  user_model.User get userData => _localStorageService.getUserData();
  set userData(user_model.User userData) {
    var tempUserData = this.userData;
    tempUserData = userData;
    _localStorageService.insertUserData(tempUserData);
  }

  bool get isCartEmpty => userData.cart == null ? true : false;

  user_model.UserCart? get userCart => userData.cart;

  Map<MenuItem, int> get cartItems {
    return userCart?.cartItems ?? {};
  }

  Restaurant? get restLocalStorageData {
    return _localStorageService.getRestaurantData(userCart!.restId);
  }

  bool isMenuItemInCart(MenuItem menuItem) {
    if (isCartEmpty) return false;

    return userCart!.cartItems.containsKey(menuItem);
  }

  void clearCart() {
    if (userCart == null) return;

    // Clearing cart
    var cartRestId = userCart!.restId;
    final menuData = _localStorageService.getMenuData(cartRestId)!;
    final cartItemsNotEmpty = userCart!.cartItems.isNotEmpty;
    if (cartItemsNotEmpty) {
      // Remove cartItems from local Storage
      _localStorageService.removeManyMenuItemsData(cartRestId);
      _localStorageService.removeMenuData(menu: menuData);
    }
    userData = userData..cart = null;
  }

  void addMenuItem({
    required String restaurantId,
    required Menu menu,
    required MenuItem menuItem,
  }) {
    // clearCart();

    if (isMenuItemInCart(menuItem)) return;

    /// 1. Store menu and the menu item in the local storage
    if (_localStorageService.getMenuData(restaurantId) == null) {
      // Menu does not exists in local storage, store it
      _localStorageService.insertMenuData(
        restaurantId: restaurantId,
        menu: menu,
      );
    }
    // Storing menu item in local Storage
    _localStorageService.insertOneMenuItemData(
      restaurantId: restaurantId,
      menuItem: menuItem,
    );

    /// 2. Update User Data with new MenuItem
    user_model.UserCart userCartData = userData.addCart(restaurantId);
    userCartData.addItem(menuItem);
    userData = userData..cart = userCartData;
  }

  int? menuItemQuantity(MenuItem menuItem) {
    return userCart?.cartItems.entries.firstWhereOrNull((cartItemMap) {
      return cartItemMap.key.id == menuItem.id;
    })?.value;
  }

  void incrementCartQuantity(MenuItem menuItem) {
    var cart = userCart;
    var cartItems = userCart!.incrementItem(menuItem);
    cart?.cartItems = cartItems;
    userData = userData..cart = cart;
  }

  void decrementCartQuantity(String restaurantId, MenuItem menuItem) {
    var cart = userCart;
    var cartItems = userCart!.decrementItem(menuItem);

    if (!cartItems.containsKey(menuItem)) {
      _localStorageService.removeOneMenuItemData(restaurantId, menuItem);
    }

    if (cartItems.isEmpty) {
      cart = null;
      _localStorageService.removeMenuData(
        menu: _localStorageService.getMenuData(restaurantId)!,
      );
    }

    cart?.cartItems = cartItems;
    userData = userData..cart = cart;
  }
}
