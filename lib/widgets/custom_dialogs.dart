import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/util/extensions/theme_data_extension.dart';

class CustomDialogs {
  static Future<T?> animatedDialog<T>({
    required Widget? child,
    // Dialog
    String? barrierLabel,
    bool barrierDismissible = false,
    Duration? transitionDuration,
    Color? backgroundColor,
    double dialogBorderRadius = 32,
    // Close Button
    bool showCloseButton = true,
    VoidCallback? onClose,
    Color? closeIconColor,
    Color? closeIconCircleColor,
    bool removeDuplicateDialog = true,
  }) async {
    if (removeDuplicateDialog && (Get.isDialogOpen ?? false)) {
      Get.back(closeOverlays: true);
    }
    return await Get.generalDialog(
      transitionDuration:
          transitionDuration ?? const Duration(milliseconds: 275),
      transitionBuilder: (_, anim1, anim2, ch) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.2, end: 1.0).animate(anim1),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.4, end: 1.0).animate(anim1),
            child: ch,
          ),
        );
      },
      barrierLabel: barrierLabel,
      barrierDismissible: barrierDismissible,
      pageBuilder: (_, __, ___) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(dialogBorderRadius),
          ),
          elevation: 0.0,
          child: Container(
            margin: const EdgeInsets.only(left: 0.0, right: 0.0),
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 13.0, right: 8.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: backgroundColor ?? Get.theme.cardColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 0.0,
                        offset: Offset(0.0, 0.0),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 275),
                    transitionBuilder: (ch, ani) {
                      return FadeTransition(
                        opacity:
                            Tween<double>(begin: 0.0, end: 1.0).animate(ani),
                        child: ch,
                      );
                    },
                    child: child ??
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Custom Animated Dialog',
                            style: TextStyle(
                              color: Get.theme.customColor()?.text07,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                  ),
                ),
                if (showCloseButton)
                  Positioned(
                    right: 0.0,
                    child: GestureDetector(
                      onTap: onClose ?? () => Get.back(),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: closeIconCircleColor ?? Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Get.theme.colorScheme.shadow
                                    .withOpacity(0.25),
                                offset: const Offset(-1, 2),
                                spreadRadius: 0,
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.close,
                            color:
                                closeIconColor ?? Get.theme.primaryColorLight,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
