import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/pages/login/login_controller.dart';

class LoginOTPButton extends GetView<LoginController> {
  const LoginOTPButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.onTapHandler,
      child: Container(
        height: 60,
        constraints: const BoxConstraints(maxWidth: 350),
        decoration: BoxDecoration(
          gradient: controller.style!.buttonGradient,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: controller.style!.buttonShadowColor,
              blurRadius: 6,
              offset: const Offset(-2, 4),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: controller.style!.buttonLineColor),
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Obx(() {
            return Text(
              controller.buttonText,
              style: TextStyle(
                color: controller.style!.buttonTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            );
          }),
        ),
      ),
    );
  }
}
