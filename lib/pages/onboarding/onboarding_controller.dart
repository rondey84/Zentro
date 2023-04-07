import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/data/model/onboard.dart';
import 'package:zentro/routes/app_pages.dart';
import 'package:zentro/services/local_storage_service.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';
import 'package:zentro/theme/extensions/onboarding_style.dart';
import 'package:zentro/util/svg_helper/svg_helper.dart';

class OnBoardingController extends GetxController {
  final style = Get.theme.extension<OnboardingStyle>();
  final fontStyle = Get.theme.extension<CustomFontStyles>();
  final pageController = PageController();

  final selectedPage = 0.obs;

  double nextButtonSize = 80.0;

  late final List<Onboard> onBoardPages;

  @override
  void onInit() {
    onBoardPages = [
      Onboard(
        image: SvgHelper.onboarding(
          onboard: OnboardingImages.welcome,
          primaryColor: style?.svgPrimary ?? Get.theme.primaryColor,
          accentColor: style?.svgAccent ?? Get.theme.colorScheme.secondary,
        ),
        title: 'Welcome',
        description:
            "Welcome to our food ordering app! We're glad you're here and ready to enjoy some delicious meals.",
      ),
      Onboard(
        image: SvgHelper.onboarding(
          onboard: OnboardingImages.easyFoodOrdering,
          primaryColor: style?.svgPrimary ?? Get.theme.primaryColor,
          accentColor: style?.svgAccent ?? Get.theme.colorScheme.secondary,
        ),
        title: 'Easy Food Ordering',
        description:
            'Our app makes it easy for you to order your favorite dishes from local restaurants. With just a few taps, you can browse menus, place orders, track deliveries, and pay for purchases.',
      ),
      Onboard(
        image: SvgHelper.onboarding(
          onboard: OnboardingImages.gettingStarted,
          primaryColor: style?.svgPrimary ?? Get.theme.primaryColor,
          accentColor: style?.svgAccent ?? Get.theme.colorScheme.secondary,
        ),
        title: 'Getting Started',
        description:
            "To get started, simply sign up for an account by inputting your personal information and setting up a payment method. Then, you'll be ready to start exploring our wide selection of dishes and placing orders.",
      ),
      Onboard(
        image: SvgHelper.onboarding(
          onboard: OnboardingImages.helpAndSupport,
          primaryColor: style?.svgPrimary ?? Get.theme.primaryColor,
          accentColor: style?.svgAccent ?? Get.theme.colorScheme.secondary,
        ),
        title: 'Help and Support',
        description:
            'If you have any questions along the way, be sure to check out our FAQs for answers to common questions about the app. You can also contact our customer support team for assistance.',
      ),
      Onboard(
        image: SvgHelper.onboarding(
          onboard: OnboardingImages.readyToOrder,
          primaryColor: style?.svgPrimary ?? Get.theme.primaryColor,
          accentColor: style?.svgAccent ?? Get.theme.colorScheme.secondary,
        ),
        title: 'Ready to Order?',
        description:
            'Ready to start using the app? Just click the "Get Started" button below to begin. Happy ordering!',
      ),
    ];
    super.onInit();
  }

  bool get isLastPage => selectedPage.value == onBoardPages.length - 1;

  void onTapHandler() {
    if (isLastPage) {
      LocalStorageService.instance.setOnBoardingStatus();
      Get.offAllNamed(AppRoutes.LOGIN_REGISTER);
    }

    pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
