import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
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
import 'package:zentro/util/extensions/theme_data_extension.dart';
import 'package:zentro/util/text_helper.dart';
import 'package:zentro/widgets/cart/floating_cart_controller.dart';
import 'package:zentro/widgets/custom_dialogs.dart';
import 'package:zentro/widgets/restaurant_header/restaurant_header_controller.dart';

class RestaurantController extends GetxController
    with GetTickerProviderStateMixin {
  // Parameters, controllers and services
  late String restaurantId;
  final _localStorageService = LocalStorageService.instance;
  final userCartService = UserCartService.instance;
  final FloatingCartController floatingCartController = Get.find();
  final RestaurantHeaderController headerController = Get.find();

  // Controllers
  late TabController tabController;

  // Restaurant Data
  Restaurant? restaurant;
  Menu? menu;
  Map<String, List<MenuItem>> menuItemsMap = {};
  Map<String, List<MenuItem>> filteredMenuItemsMap = {};
  String? restaurantAddress;

  // Page Data based observables
  final isRestaurantFav = false.obs;
  final hasMenuDataLoaded = false.obs;
  final hasRestaurantPlacemarkLoaded = false.obs;

  // Menu Categories variables
  late List<String> categories;
  List<String> filteredCategories = [];

  // Menu Filter observables
  final menuTypeFilterVisible = false.obs;
  final selectedFilterType = FoodType.unknown.obs;

  // Restaurant Header Visibility Observer
  final isRestaurantHeaderVisible = true.obs;

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
    return floatingCartController.widgetLocation;
  }

  // ======== Outlets =======
  bool get hasOutlets {
    return restaurant?.outlets?.isNotEmpty ?? false;
  }

  final _selectedOutlet = ''.obs;
  String get selectedOutlet {
    return hasOutlets
        ? _selectedOutlet.value.isEmpty
            ? restaurant?.outlets?.first ?? ''
            : _selectedOutlet.value
        : '';
  }

  set selectedOutlet(String val) => _selectedOutlet.value = val;

  @override
  void onInit() async {
    restaurantId = Get.parameters['restaurantId']!;
    _workerMethods();

    // Load Data
    await loadData();

    super.onInit();
  }

  // OPTIMIZE DATA LOADING...
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
    restaurant = await headerController.loadRestaurantData(restaurantId);

    if (restaurant == null) {
      hasError = true;
    } else {
      if (restaurant?.selectedOutlet != null) {
        selectedOutlet = restaurant!.selectedOutlet!;
      }
      if (!hasOutlets) {
        // Fetch address
        var geoLocation = (await FirebaseService.instance.fireStoreHelper
                .getRestaurantData(restaurantId))
            ?.geoLocation;
        var placemark = await LocationService.instance.fetchPlacemark(
          latitude: geoLocation!.latitude,
          longitude: geoLocation.longitude,
        );
        restaurantAddress = placemark[0].subLocality?.capitalize;
        hasRestaurantPlacemarkLoaded.value = true;
      }
      hasError = false;
    }
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

  void _calculateDistance() async {
    // MapBox errors, Google Map - Needs Payment, Find Alternative
  }

  Future<void> _fetchMenu() async {
    menu = await FirebaseService.instance.fireStoreHelper
        .getMenuData(restaurantId);

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
        var menuItems =
            await FirebaseService.instance.fireStoreHelper.getMenuItemsData(
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
    var imageUrl = await FirebaseService.instance.firebaseStorageHelper
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

  // Action Buttons Handlers
  void favButtonHandler() {
    if (!hasMenuDataLoaded.value) return;
    isRestaurantFav.value = !isRestaurantFav.value;
  }

  void outletSwitcher() {
    const animDuration = Duration(milliseconds: 300);

    Widget selectionItem(int index) {
      bool isSelected = selectedOutlet == restaurant!.outlets![index];

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () async {
            if (isSelected) return;
            selectedOutlet = restaurant!.outlets![index];
            if (Get.isBottomSheetOpen ?? false) {
              await Future.delayed(
                animDuration,
                () {
                  var res = restaurant!;
                  res.selectedOutlet = selectedOutlet;
                  _localStorageService.insertRestaurantData(res);
                  Get.back();
                },
              );
            }
          },
          child: AnimatedContainer(
            duration: animDuration,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(
                width: isSelected ? 2 : 1,
                color:
                    isSelected ? theme.primaryColor : theme.primaryColorLight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  restaurant!.outlets![index],
                  style: fontStyles?.chipTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected
                        ? theme.primaryColor
                        : theme.primaryColorLight,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Select an Outlet',
              style: fontStyles?.header1,
            ),
            ...List.generate(restaurant!.outlets!.length, (idx) {
              return Obx(() => selectionItem(idx));
            })
          ],
        ),
      ),
      backgroundColor: Get.theme.scaffoldBackgroundColor,
    );
  }

  void locationButtonHandler() => Get.toNamed(AppRoutes.RESTAURANT_MAP);
  void shareButtonHandler() {}
  void filterButtonHandler() {
    if (!hasMenuDataLoaded.value) return;
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
  void addToCardHandler(MenuItem menuItem) async {
    if (userCartService.isMenuItemInCart(menuItem)) return;

    // Check if new restaurant
    if (userCartService.userCart != null &&
        userCartService.userCart!.restId != restaurantId) {
      // Ask for confirmation first, if user sends ok then clear and add new restaurant,
      // else cancel and show the current order to user.
      final bool replaceCart = await _showReplaceCartItemDialog(
        oldRestId: userCartService.userCart!.restId,
        newRestId: restaurantId,
      );
      if (replaceCart) {
        userCartService.clearCart();
      } else {
        return;
      }
    }

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
    floatingCartController.showCart = !userCartService.isCartEmpty;
    if (userCartService.userData.cart != null) {
      floatingCartController.itemQuantity =
          userCartService.userData.cart!.totalQuantity;
      floatingCartController.priceWithoutTax =
          userCartService.userData.cart!.priceWithoutTax;
      floatingCartController.priceWithTax =
          userCartService.userData.cart!.priceWithTax;
    }
  }

  void onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction <= 0.6) {
      isRestaurantHeaderVisible.value = false;
    } else {
      isRestaurantHeaderVisible.value = true;
    }
  }

  Future<bool> _showReplaceCartItemDialog({
    required String oldRestId,
    required String newRestId,
  }) async {
    final oldRestName = _localStorageService.getRestaurantData(oldRestId)?.name;
    final newRestName = _localStorageService.getRestaurantData(newRestId)?.name;

    bool replace = false;

    Widget button({
      required Color buttonColor,
      required String text,
      required textColor,
      VoidCallback? onTap,
    }) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: ShapeDecoration(
            shape: const StadiumBorder(),
            color: buttonColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            text,
            style: fontStyles?.button.copyWith(color: textColor),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    await CustomDialogs.animatedDialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Replace cart Items?',
              style: fontStyles?.header1,
            ),
            const SizedBox(height: 8),
            Text(
              'Your cart contains dishes from $oldRestName. Do you want to discard the selection and add dishes from $newRestName?',
              style: fontStyles?.body2.copyWith(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: button(
                    buttonColor: Get.theme.primaryColor.withOpacity(0.2),
                    text: 'No',
                    textColor: Get.theme.customColor()?.text06,
                    onTap: () => Get.back(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: button(
                    buttonColor: Get.theme.primaryColor,
                    text: 'Replace',
                    textColor: Get.theme.customColor()?.text00,
                    onTap: () {
                      replace = true;
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return replace;
  }

  /// Helpers
  double textHeight(String text, TextStyle? ts) {
    return TextHelper.textSize(text, ts).height;
  }
}
