import 'package:get/get.dart';
import 'package:zentro/pages/user_profile/user_profile.dart';
import 'package:zentro/pages/user_profile/user_profile_controller.dart';

class UserProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserProfileController());
    Get.lazyPut(() => UsersOrdersController(), fenix: true);
    Get.lazyPut(() => UsersFavRestController(), fenix: true);
  }
}
