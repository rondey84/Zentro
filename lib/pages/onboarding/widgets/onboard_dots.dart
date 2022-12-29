import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/pages/onboarding/onboarding_controller.dart';

class OnBoardDots extends GetView<OnBoardingController> {
  const OnBoardDots({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        controller.onBoardPages.length,
        (index) => Obx(() {
          bool isSelected = controller.selectedPage.value == index;
          return SizedBox(
            width: 12,
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 6,
                width: isSelected ? 12 : 6,
                decoration: ShapeDecoration(
                  shape:
                      isSelected ? const StadiumBorder() : const CircleBorder(),
                  color: isSelected ? Colors.red : Colors.grey,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
