import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/pages/new_user/new_user_controller.dart';

class NewUserDots extends GetView<NewUserController> {
  const NewUserDots({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        controller.content.length,
        (idx) => Obx(() {
          bool isSelected = controller.currentPage.value == idx;
          return SizedBox(
            width: 28,
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 6,
                width: 22,
                decoration: ShapeDecoration(
                  shape: const StadiumBorder(),
                  color: isSelected
                      ? controller.buttonStyle!.buttonGradient.colors.last
                      : controller.buttonStyle!.buttonShadowColor,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
