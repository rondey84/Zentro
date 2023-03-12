import 'package:get/get.dart';
import 'package:zentro/pages/home/home.dart';
import 'package:zentro/pages/home/home_bindings.dart';
import 'package:zentro/pages/location/location_permission.dart';
import 'package:zentro/pages/location/location_permission_bindings.dart';
import 'package:zentro/pages/login/login.dart';
import 'package:zentro/pages/login/login_bindings.dart';
import 'package:zentro/pages/new_user/new_user.dart';
import 'package:zentro/pages/new_user/new_user_bindings.dart';
import 'package:zentro/pages/onboarding/onboarding.dart';
import 'package:zentro/pages/onboarding/onboarding_bindings.dart';
import 'package:zentro/pages/orders/orders.dart';
import 'package:zentro/pages/orders/orders_bindings.dart';
import 'package:zentro/pages/restaurant/restaurant.dart';
import 'package:zentro/pages/restaurant/restaurant_bindings.dart';
import 'package:zentro/pages/restaurant_map/restaurant_map.dart';
import 'package:zentro/pages/restaurant_map/restaurant_map_bindings.dart';
import 'package:zentro/pages/splash/splash.dart';
import 'package:zentro/pages/splash/splash_bindings.dart';
import 'package:zentro/pages/user_profile/user_profile.dart';
import 'package:zentro/pages/user_profile/user_profile_bindings.dart';

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
      binding: LoginBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.NEW_USER_REGISTER,
      page: () => const NewUserScreen(),
      binding: NewUserBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.LOCATION_PERMISSION,
      page: () => const LocationPermissionScreen(),
      binding: LocationPermissionBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeScreen(),
      binding: HomeBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.USER_PROFILE,
      page: () => const UserProfile(),
      binding: UserProfileBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.RESTAURANT,
      page: () => const RestaurantScreen(),
      binding: RestaurantBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.RESTAURANT_MAP,
      page: () => const RestaurantMapScreen(),
      binding: RestaurantMapBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.ORDERS,
      page: () => const OrdersScreen(),
      binding: OrdersBindings(),
      preventDuplicates: true,
    ),
  ];
}
