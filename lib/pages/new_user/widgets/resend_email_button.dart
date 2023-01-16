import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../new_user_controller.dart';

class ResendEmail extends GetView<NewUserController> {
  const ResendEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 350),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            'Did not receive email?',
            style: TextStyle(
              color: controller.style!.underLineColor,
              fontSize: 12,
            ),
          ),
          Obx(() {
            return TextButton(
              onPressed: controller.canResendEmail.value
                  ? () async => await controller.sendEmailVerification()
                  : null,
              style: TextButton.styleFrom(
                foregroundColor: controller.style!.buttonGradient.colors.last,
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Resend'),
            );
          }),
          const Spacer(),
        ],
      ),
    );
  }
}
