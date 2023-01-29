import 'package:get/get.dart';
import 'package:zentro/pages/user_profile/user_profile_controller.dart';

class UserProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserProfileController());
  }
}
