import 'package:get/get.dart';
import 'package:zentro/controllers/debug_controller.dart';
import 'package:zentro/pages/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut(() => DebugController(), fenix: true);
  }
}
