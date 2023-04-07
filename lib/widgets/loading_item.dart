import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zentro/theme/extensions/shimmer_style.dart';

class LoadingItem extends StatelessWidget {
  const LoadingItem({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.enabled = true,
    this.child,
    this.containerDecoration,
  });

  final double? height;
  final double? width;
  final double? borderRadius;
  final bool enabled;
  final Widget? child;
  final Decoration? containerDecoration;

  @override
  Widget build(BuildContext context) {
    var shimmerStyle = Get.theme.extension<ShimmerStyle>();
    return Shimmer.fromColors(
      baseColor: shimmerStyle?.baseColor ?? Colors.grey,
      highlightColor: shimmerStyle?.highlightColor ?? Colors.white,
      enabled: true,
      child: child ??
          Container(
            height: height ?? 48,
            width: width ?? 1.sw,
            decoration: containerDecoration ??
                BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(borderRadius ?? 18),
                ),
          ),
    );
  }
}
