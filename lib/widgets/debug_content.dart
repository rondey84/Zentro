import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zentro/controllers/debug_controller.dart';
import 'package:zentro/util/extensions/theme_data_extension.dart';

class DebugContent extends GetView<DebugController> {
  const DebugContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Debug Mode',
              style: controller.fontStyles?.header1,
            ),
            const SizedBox(height: 8),
            Text(
              'Please do not use this if you are unaware of what you are doing!',
              style: controller.fontStyles?.body2.copyWith(
                color: Colors.red,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            _dialogButton(
              text: 'Splash Screen',
              onTap: controller.splashScreenHandler,
            ),
            _dialogButton(
              text: 'OnBoarding Screen',
              onTap: controller.onBoardScreenHandler,
            ),
            _dialogButton(
              text: 'New User Screen',
              onTap: controller.newUserScreenHandler,
            ),
            _dialogButton(
              text: 'Show Error Snackbar',
              onTap: controller.errorSnackbarHandler,
            ),
          ],
        ),
      ),
    );
  }

  Widget _dialogButton({
    required String text,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: ShapeDecoration(
            shape: const StadiumBorder(),
            color: Get.theme.primaryColor,
          ),
          width: 1.sw,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            text,
            style: controller.fontStyles?.button.copyWith(
              color: Get.theme.customColor()?.text00,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
