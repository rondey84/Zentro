import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:zentro/data/enums/remote_config_key.dart';
import 'package:zentro/data/model/user_models.dart' as user_model;
import 'package:zentro/routes/app_pages.dart';
import 'package:zentro/services/firebase_helpers/fs_db_helper.dart';
import 'package:zentro/services/firebase_service.dart';
import 'package:zentro/services/local_storage_service.dart';
import 'package:zentro/services/location_service.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';
import 'package:zentro/theme/extensions/extended_colors_style.dart';
import 'package:zentro/theme/extensions/shimmer_style.dart';
import 'package:zentro/util/svg_helper/svg_helper.dart';
import 'package:zentro/util/text_helper.dart';
import 'package:zentro/widgets/cart/floating_cart_controller.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  var fontStyles = Get.theme.extension<CustomFontStyles>();
  var shimmerStyle = Get.theme.extension<ShimmerStyle>();
  var extendedColor = Get.theme.extension<ExtendedColorsStyle>();

  late final FloatingCartController floatingCartController;

  List<Map<String, String?>>? inCampusRestaurants = [];
  List<Map<String, String?>>? nearCampusRestaurants = [];

  RxBool hasInCampusDataLoaded = false.obs;
  RxBool hasNearCampusDataLoaded = false.obs;
  RxBool userDataHasLoaded = false.obs;

  // ======= LOCATION =========
  final locationService = LocationService.instance;

  // ========== FIREBASE SERVICES ============
  FirebaseAuthHelper get _authHelper =>
      FirebaseService.instance.firebaseAuthHelper;
  FirebaseFireStoreHelper get _fireStoreHelper =>
      FirebaseService.instance.fireStoreHelper;
  FirebaseStorageHelper get storageHelper =>
      FirebaseService.instance.firebaseStorageHelper;

  // ============ USER =============
  // Local User Data from objectbox
  user_model.User? localUserData;

  // Firebase User Data from FirebaseAuth
  User? get user => _authHelper.currentUser.value;
  String get username {
    var name = 'Welcome';
    if (user != null) {
      if (user!.displayName != null) {
        if (user!.displayName!.isNotEmpty) {
          name = user!.displayName!;
        }
      }
    }
    return name.capitalize!;
  }

  RxString get address {
    final location = 'Fetching location...'.obs;
    if (locationService.placemark != null) {
      var placemark = locationService.placemark!.value;
      location.value =
          '${placemark.subLocality!}, ${placemark.locality!}, ${placemark.country!}';
    } else {
      location.value = 'Failed to fetch location...';
    }
    return location;
  }

  Widget get profilePicture {
    if (user != null) {
      if (user!.photoURL != null) {
        if (user!.photoURL!.isNotEmpty) {
          return Image.network(user!.photoURL!);
        }
      }
    }

    return SvgHelper.profileAvatar(primaryColor: Get.theme.primaryColor);
  }

  // ======== CART ========
  FloatingActionButtonLocation get cartLocation {
    return floatingCartController.widgetLocation;
  }

  // ======= Animations =======
  AnimationController? _animationController;
  late Animation<FractionalOffset> animation;

  // ======= Page Observables =======
  final showSearch = false.obs;
  final sectionOneHeader = ''.obs;
  final sectionTwoHeader = ''.obs;
  final currentActiveOrder = ''.obs;
  final currentOrderTitleText = ''.obs;
  final currentOrderButtonText = ''.obs;

  // ====== Getx Builder Tags =======
  final bodyTag = 'body-content';

  @override
  void onInit() async {
    _workerMethods();
    _setRemoteConfigValues();
    _updateLocalUserData();
    _loadInCampusResData();
    _loadNearCampusResData();
    await _activeOrderStream();
    super.onInit();
  }

  void _workerMethods() {
    ever(showSearch, (_) => update([bodyTag]));
  }

  void _setRemoteConfigValues() {
    showSearch.value = RemoteConfigKey.showSearch.value as bool? ?? false;
    sectionOneHeader.value =
        RemoteConfigKey.sectionOneHeader.value as String? ?? 'Inside Campus';
    sectionTwoHeader.value =
        RemoteConfigKey.sectionTwoHeader.value as String? ?? 'Near Campus';
    currentOrderTitleText.value =
        RemoteConfigKey.currentOrderCardTitle.value as String? ??
            'Ongoing Order';
    currentOrderButtonText.value =
        RemoteConfigKey.currentOrderCardButtonText.value as String? ??
            'View Order';
  }

  void _updateLocalUserData() {
    if (user == null) return;

    localUserData =
        LocalStorageService.instance.getUserDataOrNull(user!.phoneNumber!);
    if (localUserData == null) {
      localUserData = user_model.User(
        phoneNumber: user!.phoneNumber!,
        uid: user!.uid,
        name: user!.displayName,
        email: user!.email,
        isEmailVerified: user!.emailVerified,
      );
      LocalStorageService.instance.insertUserData(localUserData!);
    }
    floatingCartController = Get.find();
    userDataHasLoaded.value = true;
  }

  void _loadInCampusResData() async {
    await _fireStoreHelper.getInCampusDisplayResData().then((value) {
      inCampusRestaurants = value?.reversed.toList();
    });

    if (inCampusRestaurants != null) {
      if (inCampusRestaurants!.isNotEmpty) {
        await _fetchRestaurantImageURLS(inCampusRestaurants)
            .then((_) => _cacheImages(inCampusRestaurants).then((_) {
                  hasInCampusDataLoaded.value = true;
                }));
      } else {
        hasInCampusDataLoaded.value = true;
      }
    }
  }

  void _loadNearCampusResData() async {
    await _fireStoreHelper.getNearCampusDisplayResData().then((value) {
      nearCampusRestaurants = value?.reversed.toList();
    });

    if (nearCampusRestaurants != null) {
      if (nearCampusRestaurants!.isNotEmpty) {
        await _fetchRestaurantImageURLS(nearCampusRestaurants)
            .then((_) => _cacheImages(nearCampusRestaurants).then((_) {
                  hasNearCampusDataLoaded.value = true;
                }));
      } else {
        hasNearCampusDataLoaded.value = true;
      }
    }
  }

  Future<void> _fetchRestaurantImageURLS(
    List<Map<String, String?>>? restaurants,
  ) async {
    if (restaurants == null) return;
    // Fetch image URLs
    await Future.forEach(restaurants, (restaurant) async {
      // Fetch Download Url from firebase
      var imageURL = await storageHelper.fetchRestaurantImageDownloadUrl(
        resId: restaurant['id']!,
        image: restaurant['image']!,
      );
      // Store the name and the download URL
      if (imageURL != null) {
        restaurant.update('url', (value) => value, ifAbsent: () => imageURL);
      }
    });
  }

  Future<void> _cacheImages(List<Map<String, String?>>? restaurants) async {
    if (restaurants == null) return;

    await Future.forEach(restaurants, (restaurant) async {
      if (restaurant['url'] != null) {
        var cacheFile =
            await DefaultCacheManager().getSingleFile(restaurant['url']!);
        restaurant['cacheFilePath'] = cacheFile.path;
      }
    });
  }

  Future<void> _activeOrderStream() async {
    _fireStoreHelper
        .userDocRef(user!.phoneNumber!)
        .snapshots()
        .listen((snapshot) {
      var data = snapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        var currentOrderId = data[UserFields.currentOrderId] as String?;
        if (currentOrderId != null && currentOrderId.isNotEmpty) {
          _animationController = AnimationController(
            vsync: this,
            duration: const Duration(seconds: 12),
          );
          _setAnimation();
          _animationController?.repeat(reverse: true);
        } else {
          _animationController?.dispose();
        }

        currentActiveOrder.value = currentOrderId ?? '';
      }
    });
  }

  // ======= Animation Handlers =======
  void _setAnimation() {
    animation = TweenSequence<FractionalOffset>([
      TweenSequenceItem(
        tween: Tween<FractionalOffset>(
          begin: const FractionalOffset(0, 0.7),
          end: const FractionalOffset(0, 0.3),
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<FractionalOffset>(
          begin: const FractionalOffset(0, 0.3),
          end: const FractionalOffset(0, 0.7),
        ),
        weight: 1,
      ),
    ]).animate(_animationController!);
  }

  // ======== Navigators =========
  void navigateToProfile() => Get.toNamed(AppRoutes.USER_PROFILE);

  void navigateToRestaurant({required String restaurantId}) => Get.toNamed(
        AppRoutes.RESTAURANT,
        parameters: {'restaurantId': restaurantId},
      );

  void navigateToOrderStatus() {
    if (currentActiveOrder.value.isEmpty) return;

    Get.toNamed(
      AppRoutes.ORDER_STATUS,
      parameters: {'orderId': currentActiveOrder.value},
    );
  }

  // ======== MISC =========
  double textHeight(String text, TextStyle? ts) {
    return TextHelper.textSize(text, ts).height;
  }
}
