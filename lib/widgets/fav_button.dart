import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/theme/extensions/shadows_styles.dart';

class FavButton extends StatelessWidget {
  final bool isFav;
  final VoidCallback? onTap;
  const FavButton({
    super.key,
    this.isFav = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: Get.theme.extension<ShadowStyles>()?.cardShadow01,
        ),
        child: Icon(
          isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: Get.theme.primaryColorLight,
          size: 20,
        ),
      ),
    );
  }
}
