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
        SizedBox(height: 0.04.sh),
        Container(
          width: 1.sw,
          height: 0.4.sh,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: content.image,
        ),
        SizedBox(height: 0.04.sh),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            content.title,
            style: controller.fontStyle!.display,
          ),
        ),
        SizedBox(height: 0.016.sh),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            content.description,
            style: controller.fontStyle!.caption,
            textAlign: TextAlign.justify,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
