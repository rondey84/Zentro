import 'package:get/get.dart';
import 'package:zentro/pages/restaurant_map/restaurant_map_controller.dart';

class RestaurantMapBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RestaurantMapController>(() => RestaurantMapController());
  }
}
