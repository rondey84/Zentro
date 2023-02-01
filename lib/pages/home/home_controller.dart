import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:zentro/routes/app_pages.dart';
import 'package:zentro/services/firebase_service.dart';
import 'package:zentro/services/location_service.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';
import 'package:zentro/theme/extensions/shimmer_style.dart';
import 'package:zentro/util/svg_helper/svg_helper.dart';
import 'package:zentro/util/text_helper.dart';

class HomeController extends GetxController {
  var fontStyle = Get.theme.extension<CustomFontStyles>();
  var shimmerStyle = Get.theme.extension<ShimmerStyle>();
  FirebaseService firebaseService = Get.find();
  LocationService locationService = Get.find();

  List<Map<String, String?>>? nearbyRestaurants = [];

  RxBool hasNearbyDataLoaded = false.obs;

  FirebaseAuthHelper get authHelper => firebaseService.firebaseAuthHelper;
  FirebaseFireStoreHelper get dbHelper => firebaseService.fireStoreHelper;
  FirebaseStorageHelper get storageHelper =>
      firebaseService.firebaseStorageHelper;

  User? get user => authHelper.currentUser.value;

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

  String get address {
    String location = 'Unable to determine location';
    if (locationService.placemark != null) {
      var placemark = locationService.placemark!;
      location =
          '${placemark.subLocality!}, ${placemark.locality!}, ${placemark.country!}';
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

  double get textHeight {
    return TextHelper.textSize('Sample', fontStyle!.cardHeader).height;
  }

  @override
  void onInit() {
    _loadNearbyResData();
    super.onInit();
  }

  void _loadNearbyResData() async {
    await dbHelper.getAllDisplayResData().then((value) {
      nearbyRestaurants = value;
    });

    if (nearbyRestaurants != null) {
      if (nearbyRestaurants!.isNotEmpty) {
        await _fetchRestaurantImageURLS().then((_) => _cacheImages().then((_) {
              hasNearbyDataLoaded.value = true;
            }));
      } else {
        hasNearbyDataLoaded.value = true;
      }
    }
  }

  Future<void> _fetchRestaurantImageURLS() async {
    if (nearbyRestaurants == null) return;
    // Fetch image URLs
    await Future.forEach(nearbyRestaurants!, (restaurant) async {
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

  Future<void> _cacheImages() async {
    if (nearbyRestaurants == null) return;

    await Future.forEach(nearbyRestaurants!, (restaurant) async {
      if (restaurant['url'] != null) {
        var cacheFile =
            await DefaultCacheManager().getSingleFile(restaurant['url']!);
        restaurant['cacheFilePath'] = cacheFile.path;
      }
    });
  }

  void navigateToProfile() => Get.toNamed(AppRoutes.USER_PROFILE);

  void testHandler() {}
}
