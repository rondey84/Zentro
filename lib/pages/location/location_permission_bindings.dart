import 'package:get/get.dart';
import './location_permission_controller.dart';

class LocationPermissionBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationPermissionController>(
        () => LocationPermissionController());
  }
}
