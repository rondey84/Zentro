import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/data/model/onboard.dart';
import 'package:zentro/routes/app_pages.dart';
import 'package:zentro/services/local_storage_service.dart';
import 'package:zentro/theme/extensions/onboarding_style.dart';

class OnBoardingController extends GetxController {
  var style = Get.theme.extension<OnboardingStyle>();
  LocalStorageService localStorageService = Get.find();
  var pageController = PageController();

  var selectedPage = 0.obs;

  List<Onboard> onBoardPages = [
    Onboard(
      image: 'assets/images/onboarding_1.png',
      title: 'Welcome',
      description:
          "Welcome to our food ordering app! We're glad you're here and ready to enjoy some delicious meals.",
    ),
    Onboard(
      image: 'assets/images/onboarding_1.png',
      title: 'Easy Food Ordering',
      description:
          'Our app makes it easy for you to order your favourite dishes from local restaurants. With just a few taps, you can browse menus, place orders, track deliveries, and pay for purchases.',
    ),
    Onboard(
      image: 'assets/images/onboarding_2.png',
      title: 'Getting Started',
      description:
          "To get started, simply sign up for an account by inputting your personal information and setting up a payment method. Then, you'll be ready to start exploring our wide selection of dishes and placing orders.",
    ),
    Onboard(
      image: 'assets/images/onboarding_2.png',
      title: 'Help and Support',
      description:
          'If you have any questions along the way, be sure to check out our FAQs for answers to common questions about the app. You can also contact our customer support team for assistance.',
    ),
    Onboard(
      image: 'assets/images/onboarding_2.png',
      title: 'Ready to Order?',
      description:
          'Ready to start using the app? Just click the "Get Started" button below to begin. Happy ordering!',
    ),
  ];

  bool get isLastPage => selectedPage.value == onBoardPages.length - 1;

  void onTapHandler() {
    if (isLastPage) {
      localStorageService.setOnBoardingStatus();
      Get.offAllNamed(AppRoutes.LOGIN_REGISTER);
    }

    pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
