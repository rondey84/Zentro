import 'package:get/get.dart';
import 'package:zentro/pages/home/home_controller.dart';
import 'package:zentro/widgets/cart/floating_cart_controller.dart';
import 'package:zentro/widgets/restaurant_header/restaurant_header_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => FloatingCartController(), fenix: true);
    Get.lazyPut(() => RestaurantHeaderController(), fenix: true);
  }
}
