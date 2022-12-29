import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zentro/routes/app_pages.dart';
import 'package:zentro/services/firebase_service.dart';

class SplashController extends GetxController {
  final String pageName = 'Splash Screen';
  late final FirebaseService firebaseService;

  late Rx<User?> firebaseUser;

  @override
  void onInit() async {
    // Fixed Portrait mode For Splash Screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    firebaseService = await Get.putAsync(() => FirebaseService().init());

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    if (firebaseService.initialized) {
      firebaseUser = firebaseService.firebaseAuthHelper.currentUser;
      firebaseUser.bindStream(firebaseService.firebaseAuthHelper.userChanges);
      ever(firebaseUser, _initialScreen);
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

    super.onClose();
  }

  void _initialScreen(User? user) {
    print('USER: $user');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (user == null) {
        Get.offAllNamed(AppRoutes.ONBOARDING);
      } else {
        Get.offAllNamed(AppRoutes.HOME);
      }
    });
  }
}
