import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/routes/app_pages.dart';
import 'package:zentro/services/firebase_service.dart';
import 'package:zentro/services/location_service.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';
import 'package:zentro/util/svg_helper/svg_helper.dart';

class HomeController extends GetxController {
  var fontStyle = Get.theme.extension<CustomFontStyles>();
  FirebaseService firebaseService = Get.find();
  LocationService locationService = Get.find();

  User? get user => firebaseService.firebaseAuthHelper.currentUser.value;

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

  void navigateToProfile() {
    Get.toNamed(AppRoutes.USER_PROFILE);
  }
}
