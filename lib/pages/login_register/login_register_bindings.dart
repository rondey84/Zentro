import 'package:get/get.dart';
import 'package:zentro/pages/login_register/login_register_controller.dart';

class LoginRegisterBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginRegisterController>(() => LoginRegisterController());
  }
}
