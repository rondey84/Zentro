import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/data/model/menu_item.dart';
import 'package:zentro/data/model/restaurant.dart';
import 'package:zentro/data/model/user_models.dart' as user_model;
import 'package:zentro/pages/restaurant/restaurant_controller.dart';
import 'package:zentro/routes/app_pages.dart';
import 'package:zentro/services/firebase_service.dart';
import 'package:zentro/services/local_storage_service.dart';
import 'package:zentro/services/user_cart_service.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';
import 'package:zentro/theme/extensions/shadows_styles.dart';
import 'package:zentro/theme/extensions/shimmer_style.dart';
import 'package:zentro/widgets/cart/floating_cart_controller.dart';
import 'package:zentro/widgets/restaurant_header/restaurant_header_controller.dart';

class OrdersController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late String restaurantId;
  late Restaurant? restaurant;

  final FloatingCartController floatingCartController = Get.find();
  final LocalStorageService _localStorageService = Get.find();

  final selectedIndex = 0.obs;

  // DATA
  final isRestaurantFav = false.obs;
  final hasDataLoaded = false.obs;
  final tabData = ['Your Orders', 'Detailed Bill'];

  // Design
  final fontStyles = Get.theme.extension<CustomFontStyles>();
  final shadowStyles = Get.theme.extension<ShadowStyles>();
  final shimmerStyle = Get.theme.extension<ShimmerStyle>();

  // Getters
  FloatingActionButtonLocation get cartLocation {
    return floatingCartController.widgetLocation;
  }

  user_model.UserCart? get userCart {
    return UserCartService.instance.userCart;
  }

  Map<MenuItem, int> get cartItems {
    return UserCartService.instance.cartItems;
  }

  final _isCartItemsEmpty = false.obs;
  bool get isCartItemsEmpty => _isCartItemsEmpty.value;
  set isCartItemsEmpty(bool val) => _isCartItemsEmpty.value = val;

  // ERROR
  final _hasError = false.obs;
  bool get hasError => _hasError.value;
  set hasError(bool val) => _hasError.value = val;

  // Getx Builder Tags
  final String tabsTag = 'tabs-builder-tag';
  final String pageViewTag = 'page-view-tag';
  final String yourOrdersTag = 'your-orders';
  final String itemQuantityButtonTag = 'item-quantity-button';
  final String itemPriceTag = 'item-price';
  @override
  void onInit() async {
    restaurantId = Get.parameters['restaurantId']!;
    _workerMethods();
    await loadData();

    super.onInit();
  }

  @override
  void onClose() {
    if (Get.isRegistered<RestaurantController>()) {
      // Get reference to the restaurant controller
      final restaurantController = Get.find<RestaurantController>();
      restaurantController.update([restaurantController.addToCarButtonTag]);
    }
    super.onClose();
  }

  void _workerMethods() {
    once(hasDataLoaded, (_) => update([yourOrdersTag]));
    ever(selectedIndex, (_) => update([tabsTag, pageViewTag]));

    debounce(
      isRestaurantFav,
      (val) => _toggleFavRestaurant(val),
      time: const Duration(milliseconds: 500),
    );
  }

  // DATA FETCHING
  Future<void> loadData() async {
    var restDataLoaded = await _loadRestaurantData();
    if (restDataLoaded) {
      await _getFavStatus();
      hasError = false;
      hasDataLoaded.value = true;
    } else {
      hasError = true;
    }
  }

  Future<bool> _loadRestaurantData() async {
    // Fetch from local storage
    restaurant = await Get.find<RestaurantHeaderController>()
        .loadRestaurantData(restaurantId);

    return !(restaurant == null);
  }

  Future<void> _getFavStatus() async {
    var isResFavData = _localStorageService.checkIsRestaurantFav(restaurantId);

    if (isResFavData != null) {
      isRestaurantFav.value = isResFavData;
    } else {
      isRestaurantFav.value = await FirebaseService.instance.fireStoreHelper
          .checkIsRestaurantFav(restaurantId);
    }
  }

  // FAV HANDLERS
  void favButtonHandler() {
    if (!hasDataLoaded.value) return;
    isRestaurantFav.value = !isRestaurantFav.value;
  }

  void _toggleFavRestaurant(bool isAdded) {
    var userData = _localStorageService.getUserData();
    if (isAdded) {
      FirebaseService.instance.fireStoreHelper.addFavRestaurant(restaurantId);
      userData.favRestaurants.addIf(
        !userData.favRestaurants.contains(restaurantId),
        restaurantId,
      );
    } else {
      FirebaseService.instance.fireStoreHelper
          .removeFavRestaurant(restaurantId);
      userData.favRestaurants.remove(restaurantId);
    }
    _localStorageService.insertUserData(userData);
  }

  // PAGE VIEW HANDLERs
  void tabOnPressed(int idx) {
    if (!hasDataLoaded.value) return;
    selectedIndex.value = idx;
  }

  void incrementCartQuantity(int idx) {
    UserCartService.instance
        .incrementCartQuantity(cartItems.keys.elementAt(idx));
    _updateFloatingCartState();
    update([itemQuantityButtonTag, itemPriceTag]);
  }

  void decrementCartQuantity(int idx) {
    var menuItem = cartItems.keys.elementAt(idx);
    UserCartService.instance.decrementCartQuantity(restaurantId, menuItem);
    if (!cartItems.containsKey(menuItem)) {
      update([yourOrdersTag]);
    } else {
      update([itemQuantityButtonTag, itemPriceTag]);
    }
    if (cartItems.isEmpty) {
      isCartItemsEmpty = true;
    }
    _updateFloatingCartState();
  }

  void _updateFloatingCartState() {
    floatingCartController.showCart = !UserCartService.instance.isCartEmpty;
    if (UserCartService.instance.userData.cart != null) {
      floatingCartController.itemQuantity =
          UserCartService.instance.userData.cart!.totalQuantity;
      floatingCartController.priceWithoutTax =
          UserCartService.instance.userData.cart!.priceWithoutTax;
      floatingCartController.priceWithTax =
          UserCartService.instance.userData.cart!.priceWithTax;
    }
  }

  void addMoreHandler() {
    var previousRoute = Get.previousRoute;

    if (previousRoute.contains(AppRoutes.RESTAURANT)) {
      var previousRouteRestaurantId =
          Uri.parse(previousRoute).queryParameters['restaurantId'];

      if (previousRouteRestaurantId == restaurantId) {
        Get.back();
      } else {
        Get.close(2);
        Get.toNamed(
          AppRoutes.RESTAURANT,
          parameters: {'restaurantId': restaurantId},
        );
      }
    } else {
      // Back route is not restaurant, hence navigate to restaurant
      Get.offNamed(
        AppRoutes.RESTAURANT,
        parameters: {'restaurantId': restaurantId},
      );
    }
  }
}
