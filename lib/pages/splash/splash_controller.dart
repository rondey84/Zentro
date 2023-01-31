import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zentro/routes/app_pages.dart';
import 'package:zentro/services/firebase_service.dart';
import 'package:zentro/services/local_storage_service.dart';
import 'package:zentro/services/location_service.dart';

class SplashController extends GetxController {
  final String pageName = 'Splash Screen';
  late final FirebaseService firebaseService;
  late final LocalStorageService localStorageService;
  late final LocationService locationService;

  late Rx<User?> firebaseUser;
  late Worker worker;

  @override
  void onInit() async {
    // Fixed Portrait mode For Splash Screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    firebaseService = await Get.putAsync(() => FirebaseService().init());
    localStorageService =
        await Get.putAsync(() => LocalStorageService().init());
    locationService = await Get.putAsync(() => LocationService().init());

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    if (firebaseService.initialized && localStorageService.initialized) {
      firebaseUser = firebaseService.firebaseAuthHelper.currentUser;
      firebaseUser.bindStream(firebaseService.firebaseAuthHelper.userChanges);
      worker = ever(firebaseUser, _initialScreen);
    }
  }

  @override
  void onClose() {
    // Clear Fixed Portrait mode For Splash Screen on leave
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    worker.dispose();

    super.onClose();
  }

  void _initialScreen(User? user) {
    debugPrint('USER: $user');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (user == null) {
        Get.offAllNamed(localStorageService.appData.onBoardComplete
            ? AppRoutes.LOGIN_REGISTER
            : AppRoutes.ONBOARDING);
      } else {
        Get.offAllNamed(locationService.serviceEnabled &&
                locationService.isLocationPermissionGranted
            ? AppRoutes.HOME
            : AppRoutes.LOCATION_PERMISSION);
      }
    });
  }
}
