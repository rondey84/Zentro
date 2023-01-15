import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zentro/data/model/onboard.dart';
import 'package:zentro/pages/onboarding/onboarding_controller.dart';

class OnBoardContent extends GetView<OnBoardingController> {
  final Onboard content;

  const OnBoardContent(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30.r),
        Container(
          width: 1.sw,
          height: 0.75.sw,
          alignment: Alignment.center,
          child: Image.asset(content.image),
        ),
        SizedBox(height: 30.r),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            content.title,
            style: controller.style!.titleStyle,
          ),
        ),
        SizedBox(height: 14.r),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Text(
            content.description,
            style: controller.style!.descriptionStyle,
            textAlign: TextAlign.justify,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
