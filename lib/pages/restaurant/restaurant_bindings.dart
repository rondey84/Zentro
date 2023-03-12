import 'package:get/get.dart';
import 'package:zentro/pages/restaurant/restaurant_controller.dart';
import 'package:zentro/pages/restaurant_map/restaurant_map_controller.dart';

class RestaurantBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RestaurantController>(() => RestaurantController());
    Get.lazyPut<RestaurantMapController>(() => RestaurantMapController());
  }
}
