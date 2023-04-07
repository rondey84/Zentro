import 'package:get/get.dart';
import 'package:zentro/routes/app_pages.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';
import 'package:zentro/widgets/custom_snackbars.dart';

class DebugController extends GetxController {
  var fontStyles = Get.theme.extension<CustomFontStyles>();

  void splashScreenHandler() {
    Get.offAllNamed(AppRoutes.SPLASH);
  }

  void onBoardScreenHandler() {
    Get.offAllNamed(AppRoutes.ONBOARDING);
  }

  void errorSnackbarHandler() {
    Get.back();
    CustomSnackbars.error(title: 'Error', message: 'Test Message');
  }
}
