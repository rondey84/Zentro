import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:zentro/data/constants/debug.dart';
import 'package:zentro/pages/login/login_controller.dart';
import 'package:zentro/util/svg_helper/svg_helper.dart';
import 'package:zentro/widgets/custom_dialogs.dart';
import 'package:zentro/widgets/debug_content.dart';
import 'package:zentro/widgets/gradient_border_button.dart';

part 'widgets/login_otp_button.dart';
part 'widgets/login_input_box.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          height: 1.sh - Get.statusBarHeight,
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Obx(
                  () => AnimatedContainer(
                    duration: controller.animDuration,
                    width: 1.sw,
                    height: controller.isKeyboardOpen.value ? 0.2.sh : 0.35.sh,
                    alignment: Alignment.center,
                    child: SvgHelper.mobileLogin(
                      primaryColor: Get.theme.primaryColor,
                    ),
                  ),
                ),
                Obx(
                  () => AnimatedContainer(
                    duration: controller.animDuration,
                    height: controller.isKeyboardOpen.value ? 20 : 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Obx(() {
                    return Text(
                      controller.heading,
                      style: controller.fontStyle!.display,
                    );
                  }),
                ),
                const _LoginInputBox(),
                const SizedBox(height: 16),
                const _LoginOTPButton(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Obx(() {
                    return Text(
                      controller.descriptionText,
                      style: controller.fontStyle!.caption,
                    );
                  }),
                ),
                if (DEBUG_MODE)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => CustomDialogs.animatedDialog(
                          barrierLabel: 'Debug Dialog',
                          barrierDismissible: true,
                          child: const DebugContent(),
                        ),
                        child: const Text('Debug Button'),
                      ),
                      const SizedBox(width: 16),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
