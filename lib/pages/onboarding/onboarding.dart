import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zentro/pages/onboarding/onboarding_controller.dart';
import 'package:zentro/pages/onboarding/widgets/onboard_content.dart';
import 'package:zentro/pages/onboarding/widgets/onboard_next_button.dart';

class OnBoardingScreen extends GetView<OnBoardingController> {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Expanded(
                flex: 14,
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: controller.selectedPage,
                  itemCount: controller.onBoardPages.length,
                  itemBuilder: (_, idx) {
                    return OnBoardContent(controller.onBoardPages[idx]);
                  },
                ),
              ),
              const Spacer(),
              const OnBoardingNextButton(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
