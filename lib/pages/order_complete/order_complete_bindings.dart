import 'package:get/get.dart';
import 'package:zentro/pages/order_complete/order_complete_controller.dart';

class OrderCompleteBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderCompleteController>(() => OrderCompleteController());
  }
}
