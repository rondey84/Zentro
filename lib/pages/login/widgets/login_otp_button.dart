import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/pages/login/login_controller.dart';
import 'package:zentro/widgets/gradient_border_button.dart';

class LoginOTPButton extends GetView<LoginController> {
  const LoginOTPButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GradientBorderButton(
        onTap: controller.onTapHandler,
        text: controller.buttonText,
      );
    });
  }
}
