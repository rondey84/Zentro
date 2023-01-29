import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zentro/pages/login/login_controller.dart';

import 'widgets/login_input_box.dart';
import 'widgets/login_otp_button.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                Container(
                  width: 1.sw,
                  height: 0.55.sw,
                  alignment: Alignment.center,
                  child: Image.asset(controller.image),
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
                const LoginInputBox(),
                const SizedBox(height: 16),
                const LoginOTPButton(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Obx(() {
                    return Text(
                      controller.descriptionText,
                      style: controller.fontStyle!.caption,
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
