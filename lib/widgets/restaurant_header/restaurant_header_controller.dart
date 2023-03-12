import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:zentro/data/model/restaurant.dart';
import 'package:zentro/services/firebase_service.dart';
import 'package:zentro/services/local_storage_service.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';
import 'package:zentro/theme/extensions/extended_colors_style.dart';
import 'package:zentro/theme/extensions/shadows_styles.dart';
import 'package:zentro/theme/extensions/shimmer_style.dart';
import 'package:zentro/util/text_helper.dart';

class RestaurantHeaderController extends GetxController {
  final FirebaseService firebaseService = Get.find();
  final LocalStorageService _localStorageService = Get.find();

  late Restaurant? restaurant;

  final hasRestaurantDataLoaded = false.obs;

  final shadowStyles = Get.theme.extension<ShadowStyles>();
  final fontStyles = Get.theme.extension<CustomFontStyles>();
  final shimmerStyle = Get.theme.extension<ShimmerStyle>();
  final extendedColorsStyle = Get.theme.extension<ExtendedColorsStyle>();

  final double outerRadius = 16;
  final double innerRadius = 4;

  Future<Restaurant?> loadRestaurantData(String restaurantId) async {
    // Fetch from local storage
    var restData = _localStorageService.getRestaurantData(restaurantId);

    if (restData == null) {
      // 1. Fetch Restaurant Data from server
      restaurant = await firebaseService.fireStoreHelper.getRestaurantData(
        restaurantId,
      );

      if (restaurant != null) {
        // 2. Fetch Restaurant ImageDownloadUrl from firebase storage
        var imageUrl = await firebaseService.firebaseStorageHelper
            .fetchRestaurantImageDownloadUrl(
          resId: restaurantId,
          image: restaurant!.image!,
        );
        restaurant!.imageUrl = imageUrl;
        // 3. Cache the image using ImageDownload Url
        if (imageUrl != null) {
          var cacheFile = await DefaultCacheManager().getSingleFile(imageUrl);
          restaurant!.cachedImagePath = cacheFile.path;
        }

        // 4. Store restaurant data in local storage (objectbox)
        // Code placed here so that we don't check for duplicate placement
        _localStorageService.insertRestaurantData(
          restaurant!,
          noDuplicateCheck: true,
        );
      }
    } else {
      restaurant = restData;
    }

    if (restaurant != null) {
      hasRestaurantDataLoaded.value = true;
    }

    return restaurant;
  }

  /// Helpers
  double textHeight(String text, TextStyle? ts) {
    return TextHelper.textSize(text, ts).height;
  }
}
