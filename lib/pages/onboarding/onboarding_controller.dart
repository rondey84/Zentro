import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/data/model/onboard.dart';

class OnBoardingController extends GetxController {
  var pageController = PageController();

  var selectedPage = 0.obs;

  bool get isLastPage => selectedPage.value == 2;

  List<Onboard> onBoardPages = [
    Onboard(
      image: 'assets/images/onboarding_1.svg',
      title: 'Title 1',
      description: 'Des 1',
    ),
    Onboard(
      image: 'assets/images/onboarding_1.svg',
      title: 'Title 2',
      description: 'Des 2',
    ),
    Onboard(
      image: 'assets/images/onboarding_1.svg',
      title: 'Title 3',
      description: 'Des 3',
    ),
  ];
}
