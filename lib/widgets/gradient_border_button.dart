import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/theme/extensions/gradient_border_button_style.dart';

class GradientBorderButton extends StatelessWidget {
  const GradientBorderButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    var style = Get.theme.extension<GradientBorderButtonStyle>()!;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        constraints: const BoxConstraints(maxWidth: 350),
        decoration: BoxDecoration(
          gradient: style.buttonGradient,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: style.buttonShadowColor,
              blurRadius: 6,
              offset: const Offset(-2, 4),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: style.buttonLineColor),
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: style.buttonTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
