import 'package:get/get.dart';
import './new_user_controller.dart';

class NewUserBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewUserController());
  }
}
