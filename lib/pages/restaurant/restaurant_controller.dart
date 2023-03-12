import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:zentro/data/enums/food_type_enum.dart';
import 'package:zentro/data/model/menu.dart';
import 'package:zentro/data/model/menu_item.dart';
import 'package:zentro/data/model/restaurant.dart';
import 'package:zentro/routes/app_pages.dart';
import 'package:zentro/services/firebase_service.dart';
import 'package:zentro/services/local_storage_service.dart';
import 'package:zentro/services/location_service.dart';
import 'package:zentro/services/user_cart_service.dart';
import 'package:zentro/theme/extensions/category_chips_style.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';
import 'package:zentro/theme/extensions/extended_colors_style.dart';
import 'package:zentro/theme/extensions/menu_item_style.dart';
import 'package:zentro/theme/extensions/shadows_styles.dart';
import 'package:zentro/theme/extensions/shimmer_style.dart';
import 'package:zentro/util/text_helper.dart';
import 'package:zentro/widgets/cart/floating_cart_controller.dart';
import 'package:zentro/widgets/restaurant_header/restaurant_header_controller.dart';

class RestaurantController extends GetxController
    with GetTickerProviderStateMixin {
  // Parameters, controllers and services
  late String restaurantId;
  final FirebaseService firebaseService = Get.find();
  final LocalStorageService _localStorageService = Get.find();
  final LocationService locationService = Get.find();
  final UserCartService userCartService = Get.find();
  final FloatingCartController _floatingCartController = Get.find();

  // Controllers
  late TabController tabController;

  // Restaurant Data
  late Restaurant? restaurant;
  late Menu? menu;
  Map<String, List<MenuItem>> menuItemsMap = {};
  Map<String, List<MenuItem>> filteredMenuItemsMap = {};

  // Page Data based observables
  final isRestaurantFav = false.obs;
  final hasMenuDataLoaded = false.obs;

  // Menu Categories variables
  late List<String> categories;
  List<String> filteredCategories = [];

  // Menu Filter observables
  final menuTypeFilterVisible = false.obs;
  final selectedFilterType = FoodType.unknown.obs;

  // ERROR
  final _hasError = false.obs;
  bool get hasError => _hasError.value;
  set hasError(bool val) => _hasError.value = val;

  // Design Parameters
  final theme = Get.theme;
  final extendedColorsStyle = Get.theme.extension<ExtendedColorsStyle>();
  final fontStyles = Get.theme.extension<CustomFontStyles>();
  final shadowStyles = Get.theme.extension<ShadowStyles>();
  final chipStyle = Get.theme.extension<CategoryChipsStyle>();
  final menuItemStyle = Get.theme.extension<MenuItemStyle>();
  final shimmerStyle = Get.theme.extension<ShimmerStyle>();

  final double outerRadius = 16;
  final double innerRadius = 4;

  // Getx Builders Tags
  final String categoryBarTag = 'category-bar';
  final String menuListTag = 'menu-list';
  final String categoryChipsTag = 'category-chips';
  final String menuFilterTag = 'menu-filter';
  final String addToCarButtonTag = 'add-to-cart';

  // Getters
  bool get isUnknownFoodType => selectedFilterType.value == FoodType.unknown;
  FloatingActionButtonLocation get cartLocation {
    return _floatingCartController.widgetLocation;
  }

  @override
  void onInit() async {
    restaurantId = Get.parameters['restaurantId']!;
    _workerMethods();

    // Load Data
    await loadData();

    super.onInit();
  }

  Future<void> loadData() async {
    await _loadRestaurantData();
    _getFavStatus();
    _calculateDistance();
    await _fetchMenu();
  }

  void _workerMethods() {
    debounce(
      isRestaurantFav,
      (val) => _toggleFavRestaurant(val),
      time: const Duration(milliseconds: 500),
    );

    once(hasMenuDataLoaded, (val) {
      _initializeTabController(length: categories.length);
      update([menuListTag, categoryBarTag], val);
    });

    ever(menuTypeFilterVisible, (_) => update([menuFilterTag]));

    ever(selectedFilterType, (_) {
      _closeTabController();
      if (isUnknownFoodType) {
        _initializeTabController(length: categories.length);
      } else {
        _initializeTabController(length: filteredCategories.length);
      }

      update([menuListTag, categoryBarTag]);
    });
  }

  Future<void> _loadRestaurantData() async {
    // Fetch from local storage
    restaurant = await Get.find<RestaurantHeaderController>()
        .loadRestaurantData(restaurantId);

    if (restaurant == null) {
      hasError = true;
    } else {
      hasError = false;
    }
  }

  Future<void> _getFavStatus() async {
    var isResFavData = _localStorageService.checkIsRestaurantFav(restaurantId);

    if (isResFavData != null) {
      isRestaurantFav.value = isResFavData;
    } else {
      isRestaurantFav.value = await firebaseService.fireStoreHelper
          .checkIsRestaurantFav(restaurantId);
    }
  }

  void _calculateDistance() async {
    // MapBox errors, Google Map - Needs Payment, Find Alternative
  }

  Future<void> _fetchMenu() async {
    menu = await firebaseService.fireStoreHelper.getMenuData(restaurantId);

    if (menu != null) {
      categories = menu?.categories ?? [];
      await _fetchMenuItems();
      _fetchRecommended();
      hasMenuDataLoaded.value = true;
    }
  }

  Future<void> _fetchMenuItems() async {
    if (categories.isEmpty) return;

    await Future.forEach(
      categories,
      (category) async {
        var menuItems = await firebaseService.fireStoreHelper.getMenuItemsData(
          restaurantId: restaurantId,
          menuCategory: category,
        );

        await Future.forEach(menuItems, (menu) async {
          if (menu.image != null) {
            var imageFilePath = await _cacheImage(menu.image!);
            menu.image = imageFilePath;
          }
        });
        menuItemsMap[category] = menuItems;
      },
    );
  }

  Future<String?> _cacheImage(String image) async {
    var imageUrl = await firebaseService.firebaseStorageHelper
        .fetchRestaurantImageDownloadUrl(resId: restaurantId, image: image);

    if (imageUrl != null) {
      var cacheFile = await DefaultCacheManager().getSingleFile(imageUrl);
      return cacheFile.path;
    }
    return null;
  }

  void _fetchRecommended() {
    if (menu!.recommended == null) return;
    if (menu!.recommended!.isEmpty) return;

    var recommendedCategory = 'Recommended';

    categories.insert(0, recommendedCategory);
    List<MenuItem> recommendedMenu = [];

    for (var menuId in menu!.recommended!) {
      recommendedMenu.addAll(menuItemsMap.values
          .expand((items) => items)
          .where((item) => item.id == menuId));
    }

    menuItemsMap[recommendedCategory] = recommendedMenu;
  }

  void _toggleFavRestaurant(bool isAdded) {
    var userData = _localStorageService.getUserData();
    if (isAdded) {
      firebaseService.fireStoreHelper.addFavRestaurant(restaurantId);
      userData.favRestaurants.addIf(
        !userData.favRestaurants.contains(restaurantId),
        restaurantId,
      );
    } else {
      firebaseService.fireStoreHelper.removeFavRestaurant(restaurantId);
      userData.favRestaurants.remove(restaurantId);
    }
    _localStorageService.insertUserData(userData);
  }

  // Action Buttons Handlers
  void favButtonHandler() {
    if (!hasMenuDataLoaded.value) return;
    isRestaurantFav.value = !isRestaurantFav.value;
  }

  void locationButtonHandler() => Get.toNamed(AppRoutes.RESTAURANT_MAP);
  void shareButtonHandler() {}
  void filterButtonHandler() {
    menuTypeFilterVisible.value = !menuTypeFilterVisible.value;
  }

  void vegFilterHandler() {
    if (selectedFilterType.value != FoodType.veg) {
      _filterMenuItems(filterVegType: true);
      selectedFilterType.value = FoodType.veg;
    } else {
      selectedFilterType.value = FoodType.unknown;
    }
  }

  void nonVegFilterHandler() {
    if (selectedFilterType.value != FoodType.nonVeg) {
      _filterMenuItems(filterVegType: false);
      selectedFilterType.value = FoodType.nonVeg;
    } else {
      selectedFilterType.value = FoodType.unknown;
    }
  }

  void _filterMenuItems({bool filterVegType = false}) {
    filteredMenuItemsMap = menuItemsMap.map((category, menuItems) {
      final filteredMenuItems = menuItems.where((menuItem) {
        return filterVegType ? menuItem.isVeg : !menuItem.isVeg;
      });
      return MapEntry(category, filteredMenuItems.toList());
    });
    filteredCategories = List.from(categories);

    filteredMenuItemsMap.removeWhere((category, menuItems) {
      if (menuItems.isEmpty) {
        filteredCategories.remove(category);
        return true;
      }
      return false;
    });
  }

  // Tab and Category Methods
  void _closeTabController() {
    tabController.removeListener(_updateSelectedTabIndex);
    tabController.dispose();
  }

  void _initializeTabController({required int length, int initialIndex = 0}) {
    tabController = TabController(
      length: length,
      initialIndex: initialIndex,
      vsync: this,
    );
    tabController.addListener(_updateSelectedTabIndex);
  }

  void _updateSelectedTabIndex() {
    if (!tabController.indexIsChanging) {
      update([categoryChipsTag]);
    }
  }

  void categoryOnTapHandler(int idx) {
    tabController.animateTo(idx);
  }

  // Cart Handlers
  void addToCardHandler(MenuItem menuItem) {
    if (userCartService.isMenuItemInCart(menuItem)) return;
    userCartService.addMenuItem(
      restaurantId: restaurantId,
      menu: menu!,
      menuItem: menuItem,
    );
    _updateFloatingCartState();
    update([addToCarButtonTag]);
  }

  void incrementCartQuantity(MenuItem menuItem) {
    userCartService.incrementCartQuantity(menuItem);
    _updateFloatingCartState();
    update([addToCarButtonTag]);
  }

  void decrementCartQuantity(MenuItem menuItem) {
    userCartService.decrementCartQuantity(restaurantId, menuItem);
    _updateFloatingCartState();
    update([addToCarButtonTag]);
  }

  void _updateFloatingCartState() {
    _floatingCartController.showCart = !userCartService.isCartEmpty;
    if (userCartService.userData.cart != null) {
      _floatingCartController.itemQuantity =
          userCartService.userData.cart!.totalQuantity;
      _floatingCartController.priceWithoutTax =
          userCartService.userData.cart!.priceWithoutTax;
    }
  }

  /// Helpers
  double textHeight(String text, TextStyle? ts) {
    return TextHelper.textSize(text, ts).height;
  }
}
