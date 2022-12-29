import 'package:get/get.dart';
import 'package:zentro/pages/home/home.dart';
import 'package:zentro/pages/home/home_bindings.dart';
import 'package:zentro/pages/login_register/login_register.dart';
import 'package:zentro/pages/login_register/login_register_bindings.dart';
import 'package:zentro/pages/onboarding/onboarding.dart';
import 'package:zentro/pages/onboarding/onboarding_bindings.dart';
import 'package:zentro/pages/splash/splash.dart';
import 'package:zentro/pages/splash/splash_bindings.dart';

part 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.ONBOARDING,
      page: () => const OnBoardingScreen(),
      binding: OnBoardingBinding(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.LOGIN_REGISTER,
      page: () => const LoginScreen(),
      binding: LoginRegisterBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeScreen(),
      binding: HomeBindings(),
      preventDuplicates: true,
    ),
  ];
}
