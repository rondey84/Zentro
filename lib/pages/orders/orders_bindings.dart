import 'package:get/get.dart';
import 'package:zentro/pages/orders/orders_controller.dart';

class OrdersBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrdersController>(() => OrdersController());
  }
}
