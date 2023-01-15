import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/pages/onboarding/onboarding_controller.dart';

class OnBoardingNextButton extends GetView<OnBoardingController> {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 375),
        height: 80,
        width: controller.isLastPage ? null : 80,
        constraints: const BoxConstraints(maxWidth: 270),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: TweenAnimationBuilder(
                duration: const Duration(milliseconds: 375),
                tween: Tween<double>(
                    begin: 0.0,
                    end: controller.isLastPage
                        ? 0.0
                        : controller.selectedPage.value /
                            (controller.onBoardPages.length - 2)),
                builder: (ctx, double val, ch) {
                  return CircularProgressIndicator(
                    color: controller.style!.buttonColor,
                    value: val,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: controller.onTapHandler,
                child: Container(
                  clipBehavior: Clip.none,
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: controller.style!.buttonShadowColor,
                        blurRadius: 6,
                        offset: const Offset(-2, 4),
                      )
                    ],
                    color: controller.style!.buttonBGColor,
                    borderRadius: BorderRadius.circular(
                      controller.isLastPage ? 22 : 60,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 375),
                    transitionBuilder: (ch, ani) {
                      return FadeTransition(
                        opacity: ani,
                        child: ScaleTransition(scale: ani, child: ch),
                      );
                    },
                    child: buttonWidget,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget get buttonWidget {
    if (controller.isLastPage) {
      return Text(
        'Get Started',
        key: const ValueKey(2),
        style: TextStyle(
          color: controller.style!.buttonColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      );
    }

    return Icon(
      key: const ValueKey(1),
      Icons.arrow_forward_rounded,
      color: controller.style!.buttonColor,
      size: 36,
    );
  }
}
