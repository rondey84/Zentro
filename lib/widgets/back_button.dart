import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/theme/extensions/shadows_styles.dart';

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Get.back,
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: Get.theme.extension<ShadowStyles>()?.cardShadow01,
        ),
        child: Icon(
          Icons.arrow_back_rounded,
          color: Get.theme.primaryColorDark,
          size: 20,
        ),
      ),
    );
  }
}
