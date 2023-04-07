import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/theme/extensions/gradient_border_button_style.dart';

class GradientBorderButton extends StatelessWidget {
  const GradientBorderButton({
    super.key,
    required this.onTap,
    required this.text,
    this.loading = false,
  });

  final VoidCallback onTap;
  final String text;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    var style = Get.theme.extension<GradientBorderButtonStyle>()!;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 60,
        constraints: const BoxConstraints(maxWidth: 350),
        foregroundDecoration: loading
            ? BoxDecoration(
                color: Colors.grey.withOpacity(1),
                backgroundBlendMode: BlendMode.saturation,
              )
            : null,
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
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            transitionBuilder: (ch, ani) {
              return FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(ani),
                child: ch,
              );
            },
            child: loading
                ? const Center(
                    key: ValueKey(0),
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : Text(
                    text,
                    key: const ValueKey(1),
                    style: TextStyle(
                      color: style.buttonTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
