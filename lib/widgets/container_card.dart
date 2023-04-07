import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/theme/extensions/shadows_styles.dart';

enum ShadowStyle { style1, style2, noShadow }

class ContainerCard extends StatelessWidget {
  final Widget? child;
  final ShadowStyle shadowStyle;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final BoxConstraints? boxConstraints;

  const ContainerCard({
    super.key,
    this.child,
    this.shadowStyle = ShadowStyle.style2,
    this.margin = const EdgeInsets.fromLTRB(20, 0, 20, 16),
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
    this.borderRadius = 32.0,
    this.boxConstraints,
  });

  @override
  Widget build(BuildContext context) {
    var shadowStyles = Get.theme.extension<ShadowStyles>();
    return Container(
      margin: margin,
      padding: padding,
      constraints: boxConstraints,
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: shadowStyle == ShadowStyle.style1
            ? shadowStyles?.cardShadow01
            : shadowStyle == ShadowStyle.style2
                ? shadowStyles?.cardShadow02
                : null,
      ),
      child: child,
    );
  }
}
