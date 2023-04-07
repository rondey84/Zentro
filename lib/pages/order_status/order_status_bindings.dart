import 'package:get/get.dart';
import 'package:zentro/pages/order_status/order_status_controller.dart';

class OrderStatusBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderStatusController>(() => OrderStatusController());
  }
}
