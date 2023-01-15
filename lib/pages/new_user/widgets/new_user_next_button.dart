import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/pages/new_user/new_user_controller.dart';

class NewUserNextButton extends GetView<NewUserController> {
  const NewUserNextButton({
    Key? key,
  }) : super(key: key);

  bool get isDisabled {
    return controller.currentPage.value == 2 &&
        !controller.isEmailVerified.value;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: isDisabled ? null : controller.onTapHandler,
        child: Container(
          decoration: ShapeDecoration(
            shape: const StadiumBorder(),
            color: isDisabled
                ? Colors.grey
                : controller.style!.buttonGradient.colors.last,
            shadows: [
              BoxShadow(
                color: controller.style!.buttonShadowColor,
                blurRadius: 7,
                offset: const Offset(2, 4),
              )
            ],
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 36,
            vertical: 4,
          ),
          alignment: Alignment.center,
          height: 50,
          child: Obx(() {
            return Text(
              controller.buttonText,
              style: TextStyle(
                color: controller.style!.buttonTextColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            );
          }),
        ),
      );
    });
  }
}
