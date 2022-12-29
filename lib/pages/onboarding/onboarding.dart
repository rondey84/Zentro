import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/pages/onboarding/onboarding_controller.dart';
import 'package:zentro/pages/onboarding/widgets/onboard_content.dart';
import 'package:zentro/pages/onboarding/widgets/onboard_dots.dart';
import 'package:zentro/routes/app_pages.dart';

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
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: controller.selectedPage,
                  itemCount: controller.onBoardPages.length,
                  itemBuilder: (_, idx) {
                    return OnBoardContent(controller.onBoardPages[idx]);
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.LOGIN_REGISTER);
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: Colors.amber.shade600,
                  foregroundColor: Colors.black87,
                ),
                child: const Text('Get Started'),
              ),
              const SizedBox(height: 24),
              const OnBoardDots(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
